From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 17:39:15 -0000
Organization: OPDS
Message-ID: <CB8D46AE67FC4BD2A53DA46441714E88@PhilipOakley>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Alexander Kuleshov" <kuleshovmail@gmail.com>
To: "Alexander Kuleshov" <kuleshovmail@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 18:38:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCUk-0002oD-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 18:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbbCORia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 13:38:30 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:41730 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430AbbCORi3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 13:38:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DEHwBfwgVVPGRKFlxbgwaBLIY5bbZzi28EAoEWTQEBAQEBAQYBAQEBOCAbhAoGAQUIAQEdER4BASELAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiAoDFbM4jh0NhV2LF4JEgi2DHoEWBYpVhWVhhzuCZYwLTIYihBE+MYJDAQEB
X-IPAS-Result: A2DEHwBfwgVVPGRKFlxbgwaBLIY5bbZzi28EAoEWTQEBAQEBAQYBAQEBOCAbhAoGAQUIAQEdER4BASELAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiAoDFbM4jh0NhV2LF4JEgi2DHoEWBYpVhWVhhzuCZYwLTIYihBE+MYJDAQEB
X-IronPort-AV: E=Sophos;i="5.11,405,1422921600"; 
   d="scan'208";a="545426681"
Received: from host-92-22-74-100.as13285.net (HELO PhilipOakley) ([92.22.74.100])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 15 Mar 2015 17:38:28 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265501>

From: "Alexander Kuleshov" <kuleshovmail@gmail.com>
> This patch introduces new --exclude option for the git add
> command.
>
> We already have core.excludesfile configuration variable which 
> indicates
> a path to file which contains patterns to exclude. This patch provides
> ability to pass --exclude option to the git add command to exclude 
> paths
> from command line in addition to which found in the ignore files.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> builtin/add.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 3390933..5c602a6 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -244,6 +244,16 @@ static int ignore_removal_cb(const struct option 
> *opt, const char *arg, int unse
>  return 0;
> }
>
> +struct string_list exclude_list = STRING_LIST_INIT_NODUP;
> +struct exclude_list *el;
> +
> +static int exclude_cb(const struct option *opt, const char *arg, int 
> unset)
> +{
> + struct string_list *exclude_list = opt->value;
> + string_list_append(exclude_list, arg);
> + return 0;
> +}
> +
> static struct option builtin_add_options[] = {
>  OPT__DRY_RUN(&show_only, N_("dry run")),
>  OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -255,6 +265,9 @@ static struct option builtin_add_options[] = {
>  OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked 
> files")),
>  OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the 
> fact that the path will be added later")),
>  OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all 
> tracked and untracked files")),
> + { OPTION_CALLBACK, 0, "exclude", &exclude_list, N_("pattern"),
> +   N_("do no add files matching pattern to index"),

s /no/not/   ??

> +   0, exclude_cb },
>  { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
>    NULL /* takes no arguments */,
>    N_("ignore paths removed in the working tree (same as --no-all)"),
> @@ -298,6 +311,7 @@ static int add_files(struct dir_struct *dir, int 
> flags)
>
> int cmd_add(int argc, const char **argv, const char *prefix)
> {
> + int i;
>  int exit_status = 0;
>  struct pathspec pathspec;
>  struct dir_struct dir;
> @@ -381,6 +395,11 @@ int cmd_add(int argc, const char **argv, const 
> char *prefix)
>  if (!ignored_too) {
>  dir.flags |= DIR_COLLECT_IGNORED;
>  setup_standard_excludes(&dir);
> +
> + el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
> + for (i = 0; i < exclude_list.nr; i++)
> + add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
> +
>  }
>
>  memset(&empty_pathspec, 0, sizeof(empty_pathspec));
> @@ -446,5 +465,6 @@ finish:
>  die(_("Unable to write new index file"));
>  }
>
> + string_list_clear(&exclude_list, 0);
>  return exit_status;
> }
> -- 
> 2.3.3.472.g20ceeac
>
--
Philip 
