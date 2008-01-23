From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 08:38:02 -0500
Message-ID: <20080123133802.GC7415@mit.edu>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 14:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHfoe-0000m2-SU
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 14:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYAWNiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 08:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYAWNiZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 08:38:25 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44628 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbYAWNiY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 08:38:24 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0NDc47t023168;
	Wed, 23 Jan 2008 08:38:04 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0NDc2jh006017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Jan 2008 08:38:03 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHfnm-0007cD-LH; Wed, 23 Jan 2008 08:38:02 -0500
Content-Disposition: inline
In-Reply-To: <20080123094052.GB6969@glandium.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71539>

Here's a reliable test case to test filename normalization on Mac OS.

------ cut here -------
cat > test.pl << EOF
#!/usr/bin/perl -CO
print "M".pack("U",0x00E4)."rchen\n";
print "Ma".pack("U",0x0308)."rchen\n";
EOF
chmod +x test.pl
./test.pl | xargs touch
echo M* | xxd -g1
------ cut here -------

On an NFS mounted filesystem, what you will get is this:

0000000: 4d 61 cc 88 72 63 68 65 6e 20 4d c3 a4 72 63 68  Ma..rchen M..rch
0000010: 65 6e 0a                                         en.

and on an HFS+ mounted filesystem, what you will get is this:

0000000: 4d 61 cc 88 72 63 68 65 6e 0a                    Ma..rchen.

So this demonstrates that on my MacOS 10.4.11 system, on NFS, MacOS is
doing no normalization, as it is creating two files.  On HFS+, MacOS
is mapping both filenames to the same decomposed name.

More (or not) surprisingly, given Kevin Ballard's "reliable source":

  "In Mac OS X,  SMB, MSDOS, UDF, ISO 9660 (Joliet), NTFS and ZFS file
  systems all store in one form -- NFC.  We store in NFC since that what is
  expected for these files systems."

Using a Sony Reader (which uses an internal FAT filesystem) hooked up
to a MacOS 10.4.11 system:

% /fs/u1/tmp/test.pl  | xargs touch
% echo M* | xxd -g1
0000000: 4d 61 cc 88 72 63 68 65 6e 0a                    Ma..rchen.

.. which is the decomposed form.  So it looks like on FAT/MSDOS
filesystems MacOS 10.4.11 normalizes files to NFD, which will *not* do
the right thing as far as Windows compatibility is concerned on USB
sticks, et. al.  Mac OS users would be well advised not to use
non-ASCII names in their filesystems if they care about interoperating
with other systems.  :-P

							- Ted
