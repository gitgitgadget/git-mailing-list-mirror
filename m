From: LCD 47 <lcd047@gmail.com>
Subject: DNS issue when cloning over HTTP and HTTPS
Date: Tue, 18 Jun 2013 01:23:56 +0300
Message-ID: <20130617222356.GA22255@admin.romednet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 00:37:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoi3H-0003Ms-Et
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 00:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab3FQWhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 18:37:21 -0400
Received: from ns1.romednet.com ([86.120.198.50]:29070 "EHLO ns1.romednet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab3FQWhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 18:37:17 -0400
X-Greylist: delayed 798 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2013 18:37:16 EDT
Received: from admin.romednet.com (unknown [95.76.45.66])
	by ns1.romednet.com (Postfix) with ESMTPS id 3bZ6Qh5Wxtz3hq2
	for <git@vger.kernel.org>; Tue, 18 Jun 2013 01:23:56 +0300 (EEST)
Received: by admin.romednet.com (Postfix, from userid 1034)
	id 3bZ6Qh4GqVz3SfGD; Tue, 18 Jun 2013 01:23:56 +0300 (EEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228120>

    The following snippet illustrates the problem:


$ uname -srvm
Linux 3.9.5-smp #2 SMP Mon Jun 10 02:54:26 CDT 2013 i686

$ git --version
git version 1.8.3

$ git clone https://github.com/torvalds/linux.git
Cloning into 'linux'...
fatal: unable to access 'https://github.com/torvalds/linux.git/': Could not resolve host: github.com (Could not contact DNS servers)


    Of course, DNS is working fine, and GitHub is accessible from my
machine:


$ dig github.com

; <<>> DiG 9.9.2-P2 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 20305
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 4, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;github.com.INA

;; ANSWER SECTION:
github.com.212INA204.232.175.90

;; AUTHORITY SECTION:
github.com.79055INNSns1.p16.dynect.net.
github.com.79055INNSns2.p16.dynect.net.
github.com.79055INNSns3.p16.dynect.net.
github.com.79055INNSns4.p16.dynect.net.

;; Query time: 0 msec
;; SERVER: 192.168.7.2#53(192.168.7.2)
;; WHEN: Tue Jun 18 00:46:13 2013
;; MSG SIZE  rcvd: 141


$ ping -c 3 github.com
PING github.com (204.232.175.90) 56(84) bytes of data.
64 bytes from github.com (204.232.175.90): icmp_req=1 ttl=52 time=142 ms
64 bytes from github.com (204.232.175.90): icmp_req=2 ttl=52 time=140 ms
64 bytes from github.com (204.232.175.90): icmp_req=3 ttl=52 time=154 ms

--- github.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2001ms
rtt min/avg/max/mdev = 140.184/145.555/154.217/6.183 ms

$ nc -v github.com https
github.com [204.232.175.90] 443 (https) open
^C


    A packet capture shows what's going on:  Git tries to resolve
github.com over LLMNR rather than DNS, and my router responds with
"destination unreachable".  192.168.7.2 is my machine, and 192.168.7.1
is my router:


No.     Time        Source                Destination           Length Expert Protocol Info
      1 0.000000    192.168.7.2           192.168.7.1           70            LLMNR    Standard query 0xbfe4  A github.com

Frame 1: 70 bytes on wire (560 bits), 70 bytes captured (560 bits)
Ethernet II, Src: IntelCor_94:18:a4 (00:1c:c0:94:18:a4), Dst: 22:4e:7f:5b:02:55 (22:4e:7f:5b:02:55)
Internet Protocol Version 4, Src: 192.168.7.2 (192.168.7.2), Dst: 192.168.7.1 (192.168.7.1)
User Datagram Protocol, Src Port: 55585 (55585), Dst Port: 13568 (13568)
    Source port: 55585 (55585)
    Destination port: 13568 (13568)
    Length: 36
    Checksum: 0x8f89 [validation disabled]
        [Good Checksum: False]
        [Bad Checksum: False]
Link-local Multicast Name Resolution (query)
    Transaction ID: 0xbfe4
    Flags: 0x0100 Standard query
    Questions: 1
    Answer RRs: 0
    Authority RRs: 0
    Additional RRs: 0
    Queries
        github.com: type A, class IN
            Name: github.com
            Type: A (Host address)
            Class: IN (0x0001)

No.     Time        Source                Destination           Length Expert Protocol Info
      2 0.000254    192.168.7.1           192.168.7.2           98            ICMP     Destination unreachable (Port unreachable)

Frame 2: 98 bytes on wire (784 bits), 98 bytes captured (784 bits)
Ethernet II, Src: 22:4e:7f:5b:02:55 (22:4e:7f:5b:02:55), Dst: IntelCor_94:18:a4 (00:1c:c0:94:18:a4)
Internet Protocol Version 4, Src: 192.168.7.1 (192.168.7.1), Dst: 192.168.7.2 (192.168.7.2)
Internet Control Message Protocol
    Type: 3 (Destination unreachable)
    Code: 3 (Port unreachable)
    Checksum: 0x8c86 [correct]
    Internet Protocol Version 4, Src: 192.168.7.2 (192.168.7.2), Dst: 192.168.7.1 (192.168.7.1)
    User Datagram Protocol, Src Port: 55585 (55585), Dst Port: 13568 (13568)
        Source port: 55585 (55585)
        Destination port: 13568 (13568)
        Length: 36
        Checksum: 0x9684 [validation disabled]
            [Good Checksum: False]
            [Bad Checksum: False]
    Link-local Multicast Name Resolution (query)
        Transaction ID: 0xbfe4
        Flags: 0x0100 Standard query
        Questions: 1
        Answer RRs: 0
        Authority RRs: 0
        Additional RRs: 0
        Queries
            github.com: type A, class IN
                Name: github.com
                Type: A (Host address)
                Class: IN (0x0001)


    Cloning with the git protocol works as expected.

    A search on the net shows people having the same problem more than
an year ago, and the solution there seems to imply that Git can't cope
with async DNS in curl:

http://osdir.com/ml/freebsd-ports-bugs/2012-05/msg00095.html

    Any idea?

    /lcd

PS: Please CC me on replies, as I'm not subscribed to this list.
