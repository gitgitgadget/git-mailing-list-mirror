From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2git with  modules?
Date: Tue, 17 Jun 2008 17:45:16 +0200
Message-ID: <4857DC0C.8060902@alum.mit.edu>
References: <63BEA5E623E09F4D92233FB12A9F794302389A59@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: users-return-2081-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Tue Jun 17 17:46:19 2008
Return-path: <users-return-2081-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1K8dNr-0007um-RH
	for gcvscu-users@gmane.org; Tue, 17 Jun 2008 17:46:12 +0200
Received: (qmail 9180 invoked by uid 5000); 17 Jun 2008 15:45:20 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 9170 invoked from network); 17 Jun 2008 15:45:20 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkICAON4V0jAbSoIiGdsb2JhbACSNgEBAQ8gnDw
X-IronPort-AV: E=Sophos;i="4.27,659,1204531200"; 
   d="scan'208";a="7368646"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080505 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Followup-To: git@vger.kernel.org
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302389A59@emailmn.mqsoftware.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85308>

[I see you sent essentially the same question to both the git and the
cvs2svn mailing lists.  I am replying on the git list with bcc to the
cvs2svn list.  Followups please to git@vger.kernel.org.]

Kelly F. Hickel wrote:
> I'm trying to use cvs2svn in cvs2git mode to convert a repo with a
> number of modules.  Can anyone tell me how to keep that module
> structure in the new git repo? So, if in cvs there are two modules,
> ModA and ModB, I want to see those two as top level directories in
> the git repo.
> 
> I've tried putting adding the projects in my options file as below,
> but it puts the files ModA/* and ModB/* at the top level in the git repo.
> 
> run_options.add_project(
>     r'/home/foo/cvsrepo/ModA,
>     trunk_path=ModA',
>     [...]
>     )
> 
> run_options.add_project(
>     r'/home/foo/cvsrepo/ModB,
>     trunk_path=ModB',
>     [...]
>     )

I assume that what you mean is that the CVS repository contains
directories like ModA/a, ModA/b, ModB/c, and ModB/d, but the resulting
git repository has only /a, /b, /c, and /d.  That is because cvs2git
completely ignores the trunk_path argument to add_project().

It is strange that the code allows you to add multiple projects,
considering that the cvs2git documentation[1] states that cvs2git only
supports converting single projects at a time.  I guess I forgot to
build that check in.

You can get the result you want by treating ModA and ModB not as two
separate projects, but simply as two separate subdirectories within a
bigger project; i.e.,

run_options.add_project(
    r'/home/foo/cvsrepo,
    [...]
    )

.  This is assuming that ModA and ModB are the only subdirectories
within /home/foo/cvsrepo/; otherwise, make a copy of your CVS repo and
remove the other subdirectories from the copy before the conversion.

Please note that when cvs2git is run this way, it treats tags and
branches as being global.  If you tagged your projects simultaneously,
then this is probably what you want.  But if you tagged your projects
separately, then tag names that happen to be the same across projects
will be considered the same.

It would be possible to add cvs2git support for multiproject
conversions, but I was under the impression that it doesn't make much
sense to put multiple projects into a single git repository.  But I'm a
novice git user, so I could very well be wrong about that.

Michael

[1] http://cvs2svn.tigris.org/cvs2git.html
