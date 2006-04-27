From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 13:07:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604271257010.3701@g5.osdl.org>
References: <20060427101254.GA22769@peppar.cs.umu.se>
 <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
 <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604271535460.18816@localhost.localdomain>
 <20060427194559.GA26386@brainysmurf.cs.umu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 22:08:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZCmO-000335-Eh
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 22:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWD0UHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWD0UHx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 16:07:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965060AbWD0UHx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 16:07:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RK7WtH030932
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 13:07:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RK7SsK009927;
	Thu, 27 Apr 2006 13:07:29 -0700
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20060427194559.GA26386@brainysmurf.cs.umu.se>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19242>



On Thu, 27 Apr 2006, Peter Hagervall wrote:
> > 
> > To avoid appending the filename to the path before each lstat() I'd 
> > guess.
> 
> Yes, that's pretty much the reason.

It's a bad reason, though.

For one thing, it just doesn't work. You'll have to chdir() back, and you 
can't use ".." in case the user has set up some symlink thing. So you end 
up doing other really strange things.

You can do this much more efficiently with something like this:

	const char *obj = git_object_directory();
	int len = strlen(obj);
	char *dir = malloc(len + 300);

	memcpy(dir, obj, len);
	if (len && obj[len-1] != '/')
		dir[len++] = '/';
	dir[len+2] = 0;
	for (i = 0; i < 16; i++) {
		dir[len] = hexdigit[i];
		for (j = 0; j < 16; j+) {
			dir[len+1] = hexdigit[j];
			dir[len+2] = 0;
			DIR *d = opendir(dir);
			if (!d)
				continue;
			nr += count(d, dir, len+2);
			closedir(d);
		}
	}

where the "count()" function just ends up doing something like

	int count(DIR *d, const char *prefix, int len)
	{
		int nr = 0;
		struct dirent *de;

		prefix[len++] = '/';
		while ((de = readdir(d)) != NULL) {
			int fd;
			if (de->d_name[0] == '.')
				continue;
			strcpy(prefix + len, de->d_name);
			fd = open(prefix, O_RDONLY);
			.. check if it's ok, perhaps.. ?
			if (ok)
				nr++;
			close(fd);
		}
		return nr;
	}

and you're done. Efficient, and it's easy to add the endign to the 
pathname, because you're passing in a buffer that is big enough, and 
you're telling people where they should put their suffixes..

And no, the above has never been compiled or tested, and I wrote it with 
one eye closed, while drinking heavily and experimenting with some funky 
'shrooms. So caveat emptor.

		Linus
