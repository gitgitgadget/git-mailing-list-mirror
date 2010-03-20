From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/16] worktree setup: call set_git_dir explicitly
Date: Sat, 20 Mar 2010 15:10:46 +0700
Message-ID: <fcaeb9bf1003200110w721903e7v7a5823cb312cbc71@mail.gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
	 <1268313754-28179-5-git-send-email-pclouds@gmail.com>
	 <7vljdyy2kh.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf1003111645p54f42aaetbb622f8bde0ec8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 09:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nstlq-0003Se-3Y
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 09:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab0CTIKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 04:10:51 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:54312 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab0CTIKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 04:10:48 -0400
Received: by qyk9 with SMTP id 9so2317683qyk.1
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=ip7jS1L3tzbk7EBzZdFRnxhxFI2MBCkwYXdQRo798wY=;
        b=h2esC3SudiLoKBo3PkwJK63S8yxtOpZYYgq1yj3WBP+Uzw3/KVY2/X94aX8jpMglr+
         FODVQRVAt5qBB2/1Kb9hX6cG5Rk2FHTan1CWeo0yGs3odsUIgjyHa1OIMVJyiu15+V0h
         9nNSv2u2dSTUni11fUF9jgkdcWk/B8/xXRqC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Tn0qEpEUn767AgreL6PSr5G3yE++/2c4nGN2ebPRQJeWoLQK5TFzkcUegLqBYUZh0E
         oHwN1Erq5tixb/e7qtQWEIHJ5pHhkr7PsOOaCpmLqWKX0ehw/rcl8Raf1lpTCVFbyoO7
         gwZxI8MRzy0Yc10rXyZJFhBxID3rFK4xUzhGc=
Received: by 10.229.211.75 with SMTP id gn11mr628364qcb.34.1269072646572; Sat, 
	20 Mar 2010 01:10:46 -0700 (PDT)
In-Reply-To: <fcaeb9bf1003111645p54f42aaetbb622f8bde0ec8ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142694>

Hmm.. I did not notice I did not sent this to git@vger.

On 3/12/10, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 3/12/10, Junio C Hamano <gitster@pobox.com> wrote:
>  > Yes, you have more calls to set_git_dir() than before.  But it is not
>  >  explained why "calling set_git_dir explicitly" is a good thing anywhere in
>  >  the series.
>
>
> OK. Let me try in mail first.
>
>  Goal: do not rely on setup_git_env() to set git_dir to ".git". That
>  means set_git_dir() explicitly.
>
>
>  >   - Definition.
>  >
>  >    The following state variables belong to the setup system:
>  >
>  >    - git_dir: holds the location of $GIT_DIR as a path relative to cwd
>  >    - is_bare_repository(): returns foo;
>  >    - is_inside_working_tree(): returns bar;
>  >    - ...
>
>
> Best described in 7/16 and 14/16, function unset_git_directory() and
>  unset_git_env():
>
>   - git_dir and other git_*_dir in environment.c for object store path...
>   - shared_repository, is_bare_repository_cfg, git_work_tree_cfg,
>  repository_format:  initial configuration used during setup.
>   - is_inside_work_tree: whether cwd is inside a working directory
>   - is_inside_git_dir: whether cwd is inside $GIT_DIR
>   - startup_info->prefix: relative path from new cwd to original cwd
>  when main() is called
>   - startup_info->have_repository: whether a repository is found by setup system
>   - current working directory: directory base for git_dir, work_tree
>  and stuff if they are relative
>
>
>  >   - Rule for the callers of the setup system:
>
>
> Once main() starts. startup_info should be pointed to a struct. This
>  struct will be used by various part of libgit. If startup_info is
>  NULL, everything works like before.
>
>  Since startup_info initialization until calling setup functions,
>  access to repository will not be allowed, patch 16/16. "access to
>  repository" is everything that calls git_path() and friends.
>
>  One of the setup functions is called. These functions are
>  setup_git_directory*, enter_repo() or init_db(). Only one setup call
>  can be made for the rest of program's life time. unset_git_directory()
>  can be called to undo setup and allow setup functions to be called
>  once more. But it should be avoided.
>
>  If setup system fails to find a useable repository, all involved
>  states are restored. Refer to definition part for those states.
>
>  After setup function is called:
>
>   - git_path() and friends are allowed if startup_info->have_repository is true.
>
>   - Current directory directory may be moved. Programs need to be aware
>  of "prefix" (**) to calculate original cwd.
>
>   - Changing cwd is not allowed, as some directory settings may be
>  relative to cwd.
>
>   - The current working directory may or may not be at worktree's top
>  directory (*). If a command needs worktree, it must call
>  setup_work_tree() to move cwd (and adjust prefix along the way).
>  enter_repo() will never set worktree.
>
>  (*) setup_git_directory() does the setup_work_tree()-equivalent part
>  automatically. Users of setup_git_directory_gently() must call
>  setup_work_tree().
>
>  (**) The implicit rule of prefix is, it does not contain any "../". So
>  if original cwd is outside worktree, using this prefix alone is not
>  enough to get files from command line arguments.
>
>
>  >   - Rule for the implementation of the setup system:
>  >
>  >    Upon the first call the caller makes into the setup system:
>
>
> This is hard. Let's see. Prerequisites for entering setup system:
>
>   - No setup function has been called.
>
>  The main rule is, when a repo candidate is found, these must be done in order:
>   - setup is_inside_work_tree and is_inside_git_dir
>   - check_repo_format_gently(), if fails, call unset_git_dir and finish.
>   - set_git_dir()
>   - calculate prefix, then finish.
>
>  Setup procedure:
>
>   1. Check for GIT_DIR and GIT_WORK_TREE environment variables, if these are set:
>    1.1. if GIT_WORK_TREE is not set (only GIT_DIR is set), make cwd
>  GIT_WORK_TREE
>    1.2. adjust is_inside_work_tree and is_inside_git_dir accordingly
>    1.3. check repository config for repo format version, if
>  incompatible format is found, roll back using unset_git_directory and
>  return.
>    1.4. set_git_dir() to save GIT_DIR (this is irreversible, until patch 14/16)
>    1.5. calculate prefix, set startup_info->have_repository, finish.
>
>  2. Get current working directory, check whether $(cwd)/.git or $(cwd)
>  looks like a repository, going up until GIT_CEILING_DIRECTORIES (or /)
>  is reached, then finish.
>
>    2.1. If one dir looks like a repository:
>       2.1.1. adjust is_inside_work_tree and is_inside_git_dir accordingly
>       2.1.2. check repository config for repo format version, if
>  incompatible format is found, roll back using unset_git_directory and
>  return.
>       2.1.3. set_git_dir() to save GIT_DIR
>       2.1.4. calculate prefix, set ->have_repository, finish.
>
>    2.2. If no repository is found and GIT_CEILING_DIRECTORIES is
>  reached, moving back to original cwd, finish.
>
>  During setup procedure, normal access to repository is not allowed.
>  Though in theory, it could be allowed after set_git_dir() step.
>   --
>
> Duy
>


-- 
Duy
