Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730F71F424
	for <e@80x24.org>; Sun, 22 Apr 2018 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756928AbeDVOpz (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 10:45:55 -0400
Received: from avasout01.plus.net ([84.93.230.227]:35728 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757232AbeDVOpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 10:45:52 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id AGFPfXEvbFj1OAGFQfzisL; Sun, 22 Apr 2018 15:45:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=COIEoyjD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=jnhKqsYtLS_WUIJTZXUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 0/6] Keep all info in command-list.txt in git binary
To:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, philipoakley@iee.org, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165618.GA30287@duynguyen.home>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a5dc36f7-fc79-46ba-7e73-e9473cf1aec9@ramsayjones.plus.com>
Date:   Sun, 22 Apr 2018 15:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180421165618.GA30287@duynguyen.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJ3OOPQS7QoW8JzsrpWzNA727ACyfiJUySULX6gYYaR9/RQ+ZIhI7O2bKoiYlHcOxI8d8KD7nJuK+ICNxUEq62nl0AVNn+YuzU1P81JW5CNZaIZqW+W6
 uR1JosASIYvHkh5oVvqd6QRL/39cEhs00Q2LbTT1OlGCBJ0VbuWWvOPF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/04/18 17:56, Duy Nguyen wrote:
> On Sat, Apr 21, 2018 at 06:54:08PM +0200, Nguyễn Thái Ngọc Duy wrote:
>> Changes:
>>
>> - remove the deprecated column in command-list.txt. My change break it
>>   anyway if anyone uses it.
>> - fix up failed tests that I marked in the RFC and kinda forgot about it.
>> - fix bashisms in generate-cmdlist.sh
>> - fix segfaul in "git help"
> 
> Sorry I forgot the interdiff
> 
[snip]

> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index fd2a7f27dc..53208ab20e 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -25,6 +25,15 @@ test_expect_success "setup" '
>  	EOF
>  '
>  
> +# make sure to exercise these code paths, the output is a bit tricky
> +# to verify
> +test_expect_success 'basic help commands' '
> +	git help >/dev/null &&
> +	git help -a >/dev/null &&
> +	git help -g >/dev/null &&
> +	git help -av >/dev/null
> +'
> +
I think you need to try a little harder than this! ;-)

This test would not have noticed the recent failure (what annoyed me was
that git build without error and then the test-suite sailed through with
nary a squeak of complaint). Viz:

  $ ./git help
  usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
             [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
             [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
             [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
             <command> [<args>]
  
  These are common Git commands used in various situations:
  
  'git help -a' and 'git help -g' list available subcommands and some
  concept guides. See 'git help <command>' or 'git help <concept>'
  to read about a specific subcommand or concept.
  $ echo $?
  0
  $ 

  $ ./git help -g
  The common Git guides are:
  
  
  'git help -a' and 'git help -g' list available subcommands and some
  concept guides. See 'git help <command>' or 'git help <concept>'
  to read about a specific subcommand or concept.
  $ echo $?
  0
  $ 

  $ ./git help -av
  Main Porcelain Commands
  
  
  Ancillary Commands / Manipulators
  
  
  Ancillary Commands / Interrogators
  
  
  Interacting with Others
  
  
  Low-level Commands / Manipulators
  
  
  Low-level Commands / Interrogators
  
  
  Low-level Commands / Synching Repositories
  
  
  Low-level Commands / Internal Helpers
  
  $ echo $?
  0
  $ 
 
I started to add some tests, like so:

  diff --git a/t/t0012-help.sh b/t/t0012-help.sh
  index fd2a7f27d..7e10c2862 100755
  --- a/t/t0012-help.sh
  +++ b/t/t0012-help.sh
  @@ -49,6 +49,22 @@ test_expect_success "--help does not work for guides" "
          test_i18ncmp expect actual
   "
   
  +test_expect_success 'git help' '
  +       git help >help.output &&
  +       test_i18ngrep "^   clone  " help.output &&
  +       test_i18ngrep "^   add    " help.output &&
  +       test_i18ngrep "^   log    " help.output &&
  +       test_i18ngrep "^   commit " help.output &&
  +       test_i18ngrep "^   fetch  " help.output
  +'
  +
  +test_expect_success 'git help -g' '
  +       git help -g >help.output &&
  +       test_i18ngrep "^   attributes " help.output &&
  +       test_i18ngrep "^   everyday   " help.output &&
  +       test_i18ngrep "^   tutorial   " help.output
  +'
  +
   test_expect_success 'generate builtin list' '
          git --list-cmds=builtins >builtins
   '

These tests, while not rigorous, did at least correctly catch the bad
build for me. I was about to add the obvious one for 'git help -av',
when I decided to catch the problem 'at source', viz:

  diff --git a/help.c b/help.c
  index a47f7e2c4..13790bb54 100644
  --- a/help.c
  +++ b/help.c
  @@ -196,6 +196,9 @@ static void extract_common_cmds(struct cmdname_help **p_common_cmds,
   	int i, nr = 0;
   	struct cmdname_help *common_cmds;
   
  +	if (ARRAY_SIZE(command_list) == 0)
  +		BUG("empty command_list");
  +
   	ALLOC_ARRAY(common_cmds, ARRAY_SIZE(command_list));
   
   	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
  @@ -279,6 +282,9 @@ void list_porcelain_cmds(void)
   	int i, nr = ARRAY_SIZE(command_list);
   	struct cmdname_help *cmds = command_list;
   
  +	if (nr == 0)
  +		BUG("empty command_list");
  +
   	for (i = 0; i < nr; i++) {
   		if (cmds[i].category != CAT_mainporcelain)
   			continue;
  @@ -321,6 +327,9 @@ void list_common_guides_help(void)
   	int nr = ARRAY_SIZE(command_list);
   	struct cmdname_help *cmds = command_list;
   
  +	if (nr == 0)
  +		BUG("empty command_list");
  +
   	QSORT(cmds, nr, cmd_category_cmp);
   
   	for (i = 0; i < nr; i++) {
  @@ -343,6 +352,9 @@ void list_all_cmds_help(void)
   	int nr = ARRAY_SIZE(command_list);
   	struct cmdname_help *cmds = command_list;
   
  +	if (nr == 0)
  +		BUG("empty command_list");
  +
   	for (i = 0; i < nr; i++) {
   		struct cmdname_help *cmd = cmds + i;
   
  
This had a very dramatic effect on the test-suite, since every single
test file failed while sourcing 'test-lib.sh'. [The test for having
built git ('"$GIT_BUILD_DIR/git" >/dev/null') tries to output help,
because you haven't given a command, and hits BUG - core dump!]

I haven't tried this patch series yet (I will hopefully find some
time tonight), but it looks like it will fix the problem.

ATB,
Ramsay Jones

