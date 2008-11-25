From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Mon, 24 Nov 2008 21:17:24 -0800
Message-ID: <492B8A64.7070309@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org> <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org> <m31vx3l94x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 06:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4qK4-0005Fy-6N
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 06:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbYKYFRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 00:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYKYFRg
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 00:17:36 -0500
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:45855 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750998AbYKYFRg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 00:17:36 -0500
Received: (qmail 70486 invoked from network); 25 Nov 2008 05:17:35 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp121.sbc.mail.sp1.yahoo.com with SMTP; 25 Nov 2008 05:17:34 -0000
X-YMail-OSG: Asls098VM1m_92fWiH0gRWllf0wEFc2kNNCh4Zc1K0_OrDhTJuzqgkTkesANvmOg5hZ_YlWGFOVyh97YMmZ.nWtJWmsr3j9d7SG9VrDwwmWseNEKt8IURglog6btFfRzWN0-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L4qIn-0000GE-GN; Mon, 24 Nov 2008 21:17:33 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <m31vx3l94x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101645>

> But that is contrary to the _name_ of option. It is --show-cdup, as
> in "show cd up". And I think your change will break a few scripts.
> 
> I think you should use "git rev-parse --work-tree" for full path
> to working directory:
> 
>     --show-cdup
>         When the command is invoked from a subdirectory, show the path
>         of the top-level directory relative to the current directory
>         (typically a sequence of "../", or an empty string).

Jakub,

Yes, I agree, there is a risk in breaking scripts that rely on the "../"
format.  That's the "substantial change" I was alluding.  Here's how I
arrived at that choice.  I considered these fixes:

(a) add some shell code to cd_to_toplevel to find the canonical pwd and
    interpret --show-cdup output from there

(b) make a new option (--work-tree would be a good name) to print the
    canonical work tree path, and leave --show-cdup as it is.  Then
    change cd_to_toplevel and/or git pull to use the new option

(c) change --show-cdup to print the canonical work tree path, even
    though it's not entirely consistent with the name of the option

The main reason I avoided (a), even though that "cd" is what violated my
expecations, is because I didn't want to have to re-implement code to
check whether each path component is a symlink.  (Now I see that "cd
`/bin/pwd` might be a more concise fix.)

The reason I avoided (b) is because, to make all of git work for me, I
expected to have to change several calling scripts.  (Now that I look, I
see only three calls to --show-cdup in the git codebase to change.)
Even so, third-party scripts that I might want to use in the future
would not immediately be changed.

Option (c) keeps the change small and isolated and makes it effective
everywhere.  The documentation, while perhaps in need of update given my
patch, doesn't promise to always return zero or more "../".  Also,
there's a branch branch of the --show-cdup code (that I can't seem to
exercise) that the result of get_git_work_tree(), which might not be
zero or more "../".


Would you suggest pursuing option (a)?  I wonder whether there are
languages other than shell that might suffer from the same problem of
keeping an internal PWD variable of some sort, or perhaps there are
shell scripts out there that call --show-cdup directly instead of
calling cd_to_toplevel.

Do you think it would be less likely to break existing scripts if I
restrict the (c) behavior to when getenv("PWD") doesn't match the
starting getcwd()?  (I'm not sure yet whether that's a reliable way to
detect the symlink scenario, but it seems to work with bash.)

Marcel
