From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCHv2 5/5] grep: add support for grepping in submodules
Date: Mon, 18 Oct 2010 10:37:01 +0700
Message-ID: <AANLkTikUpUZrwj9S91ZarUbfkcPgpnyx3h54dJb2W9X0@mail.gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
 <1287185204-843-6-git-send-email-judge.packham@gmail.com> <AANLkTikSukNCkcx4RYRuzzKU8T64mT0boMDqoNBrWW73@mail.gmail.com>
 <4CBBAA8F.2040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 05:37:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7gXd-0005Tt-68
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 05:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab0JRDhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 23:37:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41586 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0JRDhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 23:37:22 -0400
Received: by wyb28 with SMTP id 28so686696wyb.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=D/y7EexOLYXwSIV+EkDLgO/g4BCa7WX0rBHy7Tg9u8I=;
        b=IyiLVC86U+jCPnAJ8slatoaO3PX5CkiP4C5Z3WOFI4FfsqqYaFRJbf8fWS2kY27ETW
         rAvJ4/ydu1FhUPF+hWin6ffK3mtPJV0iTSL3cUPqlZJk64g/W4Etv7iSAmWJHkB+JAjl
         TQEiXbo6h8ow1PyQG1T/GRJlQx5crFEeNONNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=o1Yw5Vps1PERNPVaXMq+ipXBcScYeEfzSGjw6bPWo9T7msUBAfUWMWXFgpN0wJVViW
         ALMEgec6xi7bT6jD4u8pYrKJTc1IrGQ3xXQKXnZkO20fd0NIcs2SeDtzUus345nbJih/
         6pXi0BzvOf4eKr8FHrq590ydnTAbnHivcFfPQ=
Received: by 10.216.91.16 with SMTP id g16mr3973715wef.78.1287373041192; Sun,
 17 Oct 2010 20:37:21 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Sun, 17 Oct 2010 20:37:01 -0700 (PDT)
In-Reply-To: <4CBBAA8F.2040805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159228>

On Mon, Oct 18, 2010 at 9:01 AM, Chris Packham <judge.packham@gmail.com=
> wrote:
> On 17/10/10 03:28, Nguyen Thai Ngoc Duy wrote:
>> On Sat, Oct 16, 2010 at 6:26 AM, Chris Packham <judge.packham@gmail.=
com> wrote:
>>> +static int grep_submodule(struct grep_opt *opt, const char *path,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *sha1, const char *tree_name)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 struct strbuf buf =3D STRBUF_INIT;
>>> + =C2=A0 =C2=A0 =C2=A0 struct strbuf pre_buf =3D STRBUF_INIT;
>>> + =C2=A0 =C2=A0 =C2=A0 struct child_process cp;
>>> + =C2=A0 =C2=A0 =C2=A0 const char **argv =3D create_sub_grep_argv(o=
pt, path, sha1, tree_name);
>>
>> Can we just save sha1 in a env variable and drop this argv rewrite?
>>
> The tree_name is a hangover from when I was passing it as a command l=
ine
> arg, I'll remove it. For now we still need to rewrite argv to modify =
the
> pathspec and max-depth, eventually I'd like to ditch that approach in
> favour of using fork() and modifying opts.

You would also need to undo git repo setup, i.e. resetting static
variables in environment.c and setup.c, maybe some more. Also fork()
is not available on Windows.
Spawning new processes is the only feasible way I can think of now (or
even in the next year).

>>> + =C2=A0 =C2=A0 =C2=A0 const char *git_dir;
>>> + =C2=A0 =C2=A0 =C2=A0 int hit =3D 0;
>>> + =C2=A0 =C2=A0 =C2=A0 memset(&cp, 0, sizeof(cp));
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, "%s/.git", path);
>>> + =C2=A0 =C2=A0 =C2=A0 git_dir =3D read_gitfile_gently(buf.buf);
>>> + =C2=A0 =C2=A0 =C2=A0 if (!git_dir)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_dir =3D buf.=
buf;
>>> + =C2=A0 =C2=A0 =C2=A0 if (!is_directory(git_dir))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_free;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 setenv("GIT_SUPER_REFNAME", tree_name, 1);
>>> + =C2=A0 =C2=A0 =C2=A0 setenv(GIT_DIR_ENVIRONMENT, git_dir, 1);
>>> + =C2=A0 =C2=A0 =C2=A0 setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
>>
>> cp.env can be used to set these variables
>>
> I was struggling a little with how to do this. The run_command
> invocation in submodules.c uses local_repo_env which is protected
> against modification. I also don't understand how the actual values a=
re
> passed. If someone could point me in the right direction it'd be
> appreciated.

=46rom what I read in run-command.c,the current env var set is copied
as-is for new process, then any new variables from cp.env will be
added. Old variables can also be unset by saying "VARIABLE=3D" in
cp.env. The final env var set will be used for new process. Current
env vars are untouched. Something like this should work:

const char *env[4];

env[0] =3D malloc_sprintf("GIT_SUPER_REFNAME=3D%s", tree_name);
env[1] =3D malloc_sprintf("GIT_DIR_ENVIRONMENT=3D%s", git_dir);
env[2] =3D malloc_sprintf("GIT_WORK_TREE+ENVIRONMENT=3D%s", path);
env[3] =3D NULL;
cp.env =3D env;

>>> + =C2=A0 =C2=A0 =C2=A0 cp.argv =3D argv;
>>> + =C2=A0 =C2=A0 =C2=A0 cp.git_cmd =3D 1;
>>> + =C2=A0 =C2=A0 =C2=A0 cp.no_stdin =3D 1;
>>
>> I think you stll need "cp.dir =3D path;" here because the setup rout=
ines
>> won't do that for you. But I need to check/test that.
>>
> Originally I did set cp.dir but that is used by run_command (via
> start_command) to chdir. Which foils the cwd to worktree detection (a=
t
> least in V1 of that patch).

Right. I forgot that. But then when new grep is run, it should move
back to worktree. I believe current grep code assumes that cwd is
worktree root.
--=20
Duy
