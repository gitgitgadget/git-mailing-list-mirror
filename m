Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689CC2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 08:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755589AbdGKIfo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 04:35:44 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36848 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755551AbdGKIfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 04:35:19 -0400
Received: by mail-qt0-f171.google.com with SMTP id i2so92855109qta.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zzP7ZM0zM9kgBSH/DQfCRgvg03OBuu6OPvncgjWsv4c=;
        b=JPeHO2NMF7QIUJZCeXoOi8KkTBJw5ibO9jwHyM0+w+Dhqf0OS6/iUT83eYeio+iqYW
         uhVn+tTu905qpK88HGz6XCZeeR9CzdF+FoQICbPDIRyURgFBh3TllAQSkl3TWpqQ9bBT
         RZnwApXwuNKzSdDCjpfBCVtq9/bhqcZmjh3Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zzP7ZM0zM9kgBSH/DQfCRgvg03OBuu6OPvncgjWsv4c=;
        b=hOCjHjJXKCuF6xxoSvHfTT64KgV2+cl05UKhYG9hx6Eh6O+kLHj7Qm2Rzr8hwkwIDJ
         7zRH00bNzGHjTPclJNDcGbMj5hi8nuZ0vpe6+jFP3wULPWvYWMl07XRFKAND5RBs88Dk
         d0C8puUQq43LPpkcXQ+C/SWy8mUZHIo05jSXYKgnxa9cAiS8nfURrQak8kmDID+QQAkz
         XWypn9k5CYJCKVa1/w0pL+snL8N/k+CmDFSooXtchCTmA5fHiFS8AtafcipoD+es9Tw/
         ta5AYP07Lsdh8E88Xv7tAl5tQXWcnEEoKCht3VKVgZoPYNCCrqXUM1Xvm2UPpqMq9S7O
         WAng==
X-Gm-Message-State: AIVw110MtblKgjLSeGZO/pEYiqn+RkoWowzBwUyGA9Qel7YVOOLRog/9
        awfdUuIoi3pMZp8nnM4UAUqdVpJv50yy
X-Received: by 10.200.45.103 with SMTP id o36mr9780398qta.43.1499762118210;
 Tue, 11 Jul 2017 01:35:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.56.170 with HTTP; Tue, 11 Jul 2017 01:35:17 -0700 (PDT)
In-Reply-To: <20170703225731.21212-1-miguel.torroja@gmail.com>
References: <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com> <20170703225731.21212-1-miguel.torroja@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 11 Jul 2017 09:35:17 +0100
Message-ID: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 July 2017 at 23:57, Miguel Torroja <miguel.torroja@gmail.com> wrote:
> The option -G of p4 (python marshal output) gives more context about the
> data being output. That's useful when using the command "change -o" as
> we can distinguish between warning/error line and real change description.
>
> Some p4 triggers in the server side generate some warnings when
> executed. Unfortunately those messages are mixed with the output of
> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
> in python marshal output (-G). The real change output is reported as
> {'code':'stat'}
>
> the function p4CmdList accepts a new argument: skip_info. When set to
> True it ignores any 'code':'info' entry (skip_info=True by default).
>
> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
> that outputs extra lines with "p4 change -o" and "p4 changes"

The latest version of mt/p4-parse-G-output (09521c7a0) seems to break
t9813-git-p4-preserve-users.sh.

I don't quite know why, but I wonder if it's the change to p4CmdList() ?

Luke

>
> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
> ---
>  git-p4.py                | 90 ++++++++++++++++++++++++++++++++----------------
>  t/t9807-git-p4-submit.sh | 30 ++++++++++++++++
>  2 files changed, 91 insertions(+), 29 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da91..a262e3253 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -509,7 +509,7 @@ def isModeExec(mode):
>  def isModeExecChanged(src_mode, dst_mode):
>      return isModeExec(src_mode) != isModeExec(dst_mode)
>
> -def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
> +def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=True):
>
>      if isinstance(cmd,basestring):
>          cmd = "-G " + cmd
> @@ -545,6 +545,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
>      try:
>          while True:
>              entry = marshal.load(p4.stdout)
> +            if skip_info:
> +                if 'code' in entry and entry['code'] == 'info':
> +                    continue
>              if cb is not None:
>                  cb(entry)
>              else:
> @@ -879,8 +882,12 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
>              cmd += ["%s...@%s" % (p, revisionRange)]
>
>          # Insert changes in chronological order
> -        for line in reversed(p4_read_pipe_lines(cmd)):
> -            changes.add(int(line.split(" ")[1]))
> +        for entry in reversed(p4CmdList(cmd)):
> +            if entry.has_key('p4ExitCode'):
> +                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
> +            if not entry.has_key('change'):
> +                continue
> +            changes.add(int(entry['change']))
>
>          if not block_size:
>              break
> @@ -1526,37 +1533,62 @@ class P4Submit(Command, P4UserMap):
>
>          [upstream, settings] = findUpstreamBranchPoint()
>
> -        template = ""
> +        template = """\
> +# A Perforce Change Specification.
> +#
> +#  Change:      The change number. 'new' on a new changelist.
> +#  Date:        The date this specification was last modified.
> +#  Client:      The client on which the changelist was created.  Read-only.
> +#  User:        The user who created the changelist.
> +#  Status:      Either 'pending' or 'submitted'. Read-only.
> +#  Type:        Either 'public' or 'restricted'. Default is 'public'.
> +#  Description: Comments about the changelist.  Required.
> +#  Jobs:        What opened jobs are to be closed by this changelist.
> +#               You may delete jobs from this list.  (New changelists only.)
> +#  Files:       What opened files from the default changelist are to be added
> +#               to this changelist.  You may delete files from this list.
> +#               (New changelists only.)
> +"""
> +        files_list = []
>          inFilesSection = False
> +        change_entry = None
>          args = ['change', '-o']
>          if changelist:
>              args.append(str(changelist))
> -
> -        for line in p4_read_pipe_lines(args):
> -            if line.endswith("\r\n"):
> -                line = line[:-2] + "\n"
> -            if inFilesSection:
> -                if line.startswith("\t"):
> -                    # path starts and ends with a tab
> -                    path = line[1:]
> -                    lastTab = path.rfind("\t")
> -                    if lastTab != -1:
> -                        path = path[:lastTab]
> -                        if settings.has_key('depot-paths'):
> -                            if not [p for p in settings['depot-paths']
> -                                    if p4PathStartsWith(path, p)]:
> -                                continue
> -                        else:
> -                            if not p4PathStartsWith(path, self.depotPath):
> -                                continue
> +        for entry in p4CmdList(args):
> +            if not entry.has_key('code'):
> +                continue
> +            if entry['code'] == 'stat':
> +                change_entry = entry
> +                break
> +        if not change_entry:
> +            die('Failed to decode output of p4 change -o')
> +        for key, value in change_entry.iteritems():
> +            if key.startswith('File'):
> +                if settings.has_key('depot-paths'):
> +                    if not [p for p in settings['depot-paths']
> +                            if p4PathStartsWith(value, p)]:
> +                        continue
>                  else:
> -                    inFilesSection = False
> -            else:
> -                if line.startswith("Files:"):
> -                    inFilesSection = True
> -
> -            template += line
> -
> +                    if not p4PathStartsWith(value, self.depotPath):
> +                        continue
> +                files_list.append(value)
> +                continue
> +        # Output in the order expected by prepareLogMessage
> +        for key in ['Change','Client','User','Status','Description','Jobs']:
> +            if not change_entry.has_key(key):
> +                continue
> +            template += '\n'
> +            template += key + ':'
> +            if key == 'Description':
> +                template += '\n'
> +            for field_line in change_entry[key].splitlines():
> +                template += '\t'+field_line+'\n'
> +        if len(files_list) > 0:
> +            template += '\n'
> +            template += 'Files:\n'
> +        for path in files_list:
> +            template += '\t'+path+'\n'
>          return template
>
>      def edit_template(self, template_file):
> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
> index 3457d5db6..b630895a7 100755
> --- a/t/t9807-git-p4-submit.sh
> +++ b/t/t9807-git-p4-submit.sh
> @@ -409,6 +409,36 @@ test_expect_success 'description with Jobs section and bogus following text' '
>         )
>  '
>
> +test_expect_success 'description with extra lines from verbose p4 trigger' '
> +       test_when_finished cleanup_git &&
> +       git p4 clone --dest="$git" //depot &&
> +       (
> +               p4 triggers -i <<-EOF
> +               Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
> +               EOF
> +       ) &&
> +       (
> +               p4 change -o |  grep -s "verbose trigger"
> +       ) &&
> +       (
> +               cd "$git" &&
> +               git config git-p4.skipSubmitEdit true &&
> +               echo file20 >file20 &&
> +               git add file20 &&
> +               git commit -m file20 &&
> +               git p4 submit
> +       ) &&
> +       (
> +               p4 triggers -i <<-EOF
> +               Triggers:
> +               EOF
> +       ) &&
> +       (
> +               cd "$cli" &&
> +               test_path_is_file file20
> +       )
> +'
> +
>  test_expect_success 'submit --prepare-p4-only' '
>         test_when_finished cleanup_git &&
>         git p4 clone --dest="$git" //depot &&
> --
> 2.11.0
>
