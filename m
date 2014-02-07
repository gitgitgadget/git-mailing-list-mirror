From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 9/9] submodule: teach unpack_trees() to update submodules
Date: Fri, 07 Feb 2014 22:32:28 +0100
Message-ID: <52F550EC.20202@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de> <52EFF3E9.2060403@web.de> <CACsJy8CiAPnatithenDKBBKVGFHQZsu4mJLEjuWFD2GXqO56Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:32:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBt2J-0000ZW-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaBGVcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:32:31 -0500
Received: from mout.web.de ([212.227.17.11]:65054 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbaBGVca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:32:30 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LuM1L-1VBZjX2Nq3-011lcj for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:32:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CACsJy8CiAPnatithenDKBBKVGFHQZsu4mJLEjuWFD2GXqO56Lw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:XqU65i66zuobONfG9zB6/MopSv0ORcBhl/ggTRE1NQum4Tmbalc
 psqw5cjo76IgviuUsSqaKsRyhqu6elbNeGquPS0SetIsdLrQtny7NdmPR0N/CU+2HpA/0jD
 zRE4TVR88dONiEYwtmTNYf54jqOoy6Zc960/vuBXcpeZd6CsaUxQ2dlhrIOP1QURGyoYYIN
 Bv5s9SFcrsX77awzCKKww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241805>

Am 04.02.2014 01:11, schrieb Duy Nguyen:
> On Tue, Feb 4, 2014 at 2:54 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Implement the functionality needed to enable work tree manipulating
>> commands so that an changed submodule does not only affect the index but
>> it also updates the work tree of any initialized submodule according to
>> the SHA-1 recorded in the superproject.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>  entry.c        | 15 ++++++++--
>>  submodule.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  submodule.h    |  3 ++
>>  unpack-trees.c | 69 ++++++++++++++++++++++++++++++++++++----------
>>  unpack-trees.h |  1 +
>>  5 files changed, 157 insertions(+), 17 deletions(-)
>>
>> diff --git a/entry.c b/entry.c
>> index d1bf6ec..61a2767 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -265,7 +265,7 @@ int checkout_entry(struct cache_entry *ce,
>>
>>         if (!check_path(path, len, &st, state->base_dir_len)) {
>>                 unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
>> -               if (!changed)
>> +               if (!changed && (!S_ISDIR(st.st_mode) || !S_ISGITLINK(ce->ce_mode)))
>>                         return 0;
> 
> Should we report something when ce is a gitlink, but path is not a
> directory, instead of siliently exit?

Good point.

>> diff --git a/submodule.c b/submodule.c
>> index 3907034..83e7595 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -520,6 +520,42 @@ int depopulate_submodule(const char *path)
>>         return 0;
>>  }
>>
>> +int update_submodule(const char *path, const unsigned char sha1[20], int force)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +       struct child_process cp;
>> +       const char *hex_sha1 = sha1_to_hex(sha1);
>> +       const char *argv[] = {
>> +               "checkout",
>> +               force ? "-fq" : "-q",
> 
> respect "state->quiet" in checkout_entry() as well?

See below.

>> +               hex_sha1,
>> +               NULL,
>> +       };
>> +       const char *git_dir;
>> +
>> +       strbuf_addf(&buf, "%s/.git", path);
>> +       git_dir = read_gitfile(buf.buf);
>> +       if (!git_dir)
>> +               git_dir = buf.buf;
>> +       if (!is_directory(git_dir)) {
>> +               strbuf_release(&buf);
>> +               /* The submodule is not populated, so we can't check it out */
>> +               return 0;
>> +       }
>> +       strbuf_release(&buf);
>> +
>> +       memset(&cp, 0, sizeof(cp));
>> +       cp.argv = argv;
>> +       cp.env = local_repo_env;
>> +       cp.git_cmd = 1;
>> +       cp.no_stdin = 1;
>> +       cp.dir = path;   /* GIT_WORK_TREE doesn't work for git checkout */
> 
> And if we do respect --quiet and it's not specified, paths printed by
> this process is relative to "dir", not to user cwd. Could be
> confusing.

That's the reason I'm currently always passing -q to checkout. While
checkout would have to learn a "--prefix=" option to be able to print
the path relative to the superproject, some (most?) users don't want
to see this detailed information from inside the submodule. After all
git status and diff currently also only show a condensed view of the
submodule state and don't print any detailed information about files
inside the submodule. We might want to add means to enable that later,
and then we'd have to conditionally provide --quiet (and --prefix)
here.

>> +       if (run_command(&cp))
>> +               return error("Could not checkout submodule %s", path);
>> +
>> +       return 0;
>> +}
>> +
