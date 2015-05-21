From: <steve.norman@thomsonreuters.com>
Subject: Troubleshoot clone issue to NFS.
Date: Thu, 21 May 2015 13:13:32 +0000
Message-ID: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 21 15:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQRx-0007cg-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbbEUNXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 09:23:39 -0400
Received: from mailout2-trp.thomsonreuters.com ([163.231.6.26]:19230 "EHLO
	mailout2-trp.thomsonreuters.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755334AbbEUNXg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:23:36 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2015 09:23:36 EDT
Received: from trpusmneagrly02.int.westgroup.com (relay2 [163.231.22.113])
	by mailout2-trp.thomsonreuters.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t4LDDYeG001417
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 21 May 2015 13:13:35 GMT
Received: from EAGE-ERFPHUB06.ERF.thomson.com (EAGE-ERFPHUB06.erf.thomson.com [163.231.23.45])
	by trpusmneagrly02.int.westgroup.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t4LDDXbY004793
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 21 May 2015 13:13:34 GMT
Received: from C597JHEEHUB03.ERF.thomson.com (163.231.29.203) by
 EAGE-ERFPHUB06.ERF.thomson.com (163.231.23.45) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Thu, 21 May 2015 08:13:33 -0500
Received: from C111KXTEMBX51.ERF.thomson.com ([fe80::4999:4010:4bd1:ba61]) by
 C597JHEEHUB03.ERF.thomson.com ([fe80::21ac:e4a1:cd8a:978d%15]) with mapi id
 14.03.0158.001; Thu, 21 May 2015 08:13:33 -0500
Thread-Topic: Troubleshoot clone issue to NFS.
Thread-Index: AdCTxW/SgCCnMnTuQvaf51AB2UW2tg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.30.5]
X-TM-AS-Product-Ver: SMEX-10.2.0.3308-7.500.1018-21558.006
X-TM-AS-Result: No--19.088300-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269591>

In setting up some new git servers I was trying to test the performance of some NFS mounted volumes and when compared to local disk (although this is a vitualized server so not truly local) cloning to NFS was taking a long time.

Here are some timings:

~ $ time bin/git clone https://github.com/git/git test
Cloning into 'test'...
remote: Counting objects: 185964, done.
remote: Compressing objects: 100% (276/276), done.
remote: Total 185964 (delta 203), reused 32 (delta 32), pack-reused 185656
Receiving objects: 100% (185964/185964), 61.42 MiB | 26.16 MiB/s, done.
Resolving deltas: 100% (135454/135454), done.
Checking connectivity... done.

real    0m8.156s
user    0m10.569s
sys     0m3.857s

~ $ time bin/git clone https://github.com/git/git /sami/test
Cloning into '/sami/test'...
remote: Counting objects: 185964, done.
remote: Compressing objects: 100% (276/276), done.
remote: Total 185964 (delta 203), reused 32 (delta 32), pack-reused 185656
Receiving objects: 100% (185964/185964), 61.42 MiB | 10.15 MiB/s, done.
Resolving deltas: 100% (135454/135454), done.
Checking connectivity... done.
Checking out files: 100% (2795/2795), done.

real    0m58.685s
user    0m12.153s
sys     0m7.619s

So cloning to NFS is 50 seconds slower on average (I've run this a lot over the last few days and it does appear to be consistent and not a network / github connectivity issue).  Tests creating files on the NFS with dd didn't show that much difference to the local disk (and were sometimes quicker).

Volume mount differences are:

/dev/mapper/rootvg-homelv on /home type ext4 (rw,nodev)
nfsserver:/vol/sami/repos on /sami type nfs (rw,bg,nfsvers=3,tcp,hard,nointr,timeo=600,rsize=32768,wsize=32768,addr=10.1.1.1)

And there doesn't appear to be any issue with NFS retransmissions:

/sami $ nfsstat
Client rpc stats:
calls      retrans    authrefrsh
11719847   0          11720190

This morning I did some more digging as when I tried this on a newly build server the NFS times were slower than local disk, but only buy around 6-10 seconds.  The new server had git 1.7.1  installed on it compared to 2.4.0 on the machine I've been testing on.  So I build a number of versions of git to test each one to try and find the point where it changed:

v1.8.0          11.363 s
v1.8.3          13.597 s
v1.8.4          13.958 s
v1.8.4.1                14.563 s
v1.8.4.2                1m 0s
v1.8.4.3                1m 9s
v1.8.4.5                1m 1s
v1.8.5          1m 0s
v1.8.5.6                1m 0s
v1.9.0          1m 38

v2.4.0          58s
v2.4.1          58s

So there appears to be a change in 1.8.4.2 that made this issue appear for me.  Looking at the release notes the only thing that I can see that might be related could be:

* When an object is not found after checking the packfiles and then
   loose object directory, read_sha1_file() re-checks the packfiles to
   prevent racing with a concurrent repacker; teach the same logic to
   has_sha1_file().

So the questions are:

1) Should I expect a clone to NFS to be that much slower?
2) Is there anything I could do to speed it up (I've tried --bare as that is what the repositories will be when stored on NFS and there wasn't really a difference).
3) What else can I use in git to compare the performance on local to NFS to see if it is just clones that are affected?
4) I assume I could bisect between 1.8.4.1 and 1.8.4.2 to find exactly where things get worse for me?

Thanks for any help,

Steve

________________________________

This e-mail is for the sole use of the intended recipient and contains information that may be privileged and/or confidential. If you are not an intended recipient, please notify the sender by return e-mail and delete this e-mail and any attachments. Certain required legal entity disclosures can be accessed on our website.<http://thomsonreuters.com/prof_disclosures/>
