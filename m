From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 09:53:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> 
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> 
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>  <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
  <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> 
 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> 
 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 18:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G92vH-0003mT-3G
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWHDQxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbWHDQxP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:53:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161298AbWHDQxO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 12:53:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k74GrAnW029809
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Aug 2006 09:53:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k74Gr98X007238;
	Fri, 4 Aug 2006 09:53:09 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
X-Spam-Status: No, hits=-0.452 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24807>



On Fri, 4 Aug 2006, Jon Smirl wrote:
> 
> How about forking off a pack-objects and handing it one file name at a
> time over a pipe. When I hand it the next file name I delete the first
> file. Does pack-objects make multiple passes over the files? This
> model would let me hand it all 1M files.

pack-objects does actually make several (well, two) passes over the 
objects right now, because it first does all the sorting based on object 
size/type, and then does the actual deltifying pass. 

But doing things one file-name at a time would certainly be fine. You can 
even do it with git-pack-objects running in parallel, ie you can do a

	for_each_filename() {
		cvs-generate-objects filename | git-pack-objects filename
		rm -rf .git/objects/??/
	}

and then "cvs-generate-objects" should just make sure that it writes the 
git object _before_ it actually outputs the object name on stdout.

And if you do it this way, you won't even have to pass any filenames, 
since git-pack-objects will only get objects for the same file, and will 
do the right thing just sorting them by size.

So in the above kind of setting, the _only_ thing that 
cvs-generate-objects needs to do is:

	for_each_rev(file) {
		unsigned char sha1[20];
		unsigned long len;
		void *buf;

		/* unpack the revision into memory */
		buf = cvs_unpack_revision(&len);

		/* Write it out as a git blob file */
		write_sha1_file(buf, len, "blob", sha1);

		/* Free the memory image */
		free(buf);

		/* Tell git-pack-objects the name of the git blob */
		printf("%s\n", sha1_to_hex(sha1));
	}

and you're basically all done. The above would turn each *,v file into a 
*-<sha>.pack/*-<sha>.idx file pair, so you'd have exactly as many 
pack-files as you have *,v files.

		Linus
