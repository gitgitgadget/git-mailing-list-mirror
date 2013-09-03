From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Tue, 03 Sep 2013 21:32:23 +0200
Message-ID: <52263947.6040400@web.de>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr> <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr> <521FA6ED.9010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwLR-0005hd-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933178Ab3ICTcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:32:47 -0400
Received: from mout.web.de ([212.227.15.14]:60064 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933096Ab3ICTc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:32:26 -0400
Received: from [192.168.178.41] ([91.3.162.32]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LyDqv-1W2fcA3toL-015bCx for <git@vger.kernel.org>;
 Tue, 03 Sep 2013 21:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <521FA6ED.9010005@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:t54JGsAnqLWv+QJpboBNGL0sWaHX0JxLQcKiwu1Iu2uLRFECNhI
 W2qWqOnZsuKC73jv8TqaPPvvPCNDzI+ptvUXbeq2+iYD33dgA4DGj/gbT0c8rbKsLRPAvNg
 4UIi0EUBcgbWSpBRBGVtyk0ozID2nkr2nl+y2rjC0qx81fOr+lobk+FjB/7Cy828a9W9WbT
 Mq85o4LaYA7kk9F5XGGjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233764>

Am 29.08.2013 21:54, schrieb Jens Lehmann:
> Am 29.08.2013 15:05, schrieb Matthieu Moy:
>> The --for-status option was an undocumented option used only by
>> wt-status.c, which inserted a header and commented out the output. We can
>> achieve the same result within wt-status.c, without polluting the
>> submodule command-line options.
>>
>> This will make it easier to disable the comments from wt-status.c later.
> 
> Cool, thanks for implementing this!
> 
> But unfortunately this change collides with bc/submodule-status-ignored
> (I added Brian to the CC) which is currently on its way to next. Your
> patch will break the fix in the second commit, because that's only
> enabled when the submodule script sees the --for-status option.
> 
> A solution for that would be to rebase your patches on top of pu, drop
> the first two hunks of the change to git-submodule.sh and still pass
> the --for-status option to git-submodule.sh. This would move adding the
> comment characters into wt-status.c but will still enable the script to
> honor the ignore=all setting when called by status.

I think we should go that route, --for-status is an internal option and
nobody should rely on its behavior.

>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  git-submodule.sh             | 17 +----------------
>>  t/t7401-submodule-summary.sh | 13 -------------
>>  wt-status.c                  | 29 +++++++++++++++++++++++++++--
>>  3 files changed, 28 insertions(+), 31 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 2979197..fccdec9 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -965,7 +965,6 @@ set_name_rev () {
>>  #
>>  cmd_summary() {
>>  	summary_limit=-1
>> -	for_status=
>>  	diff_cmd=diff-index
>>  
>>  	# parse $args after "submodule ... summary".
>> @@ -978,9 +977,6 @@ cmd_summary() {
>>  		--files)
>>  			files="$1"
>>  			;;
>> -		--for-status)
>> -			for_status="$1"
>> -			;;
>>  		-n|--summary-limit)
>>  			summary_limit="$2"
>>  			isnumber "$summary_limit" || usage

Please drop the two hunks above ...

>> @@ -1149,18 +1145,7 @@ cmd_summary() {
>>  			echo
>>  		fi
>>  		echo
>> -	done |
>> -	if test -n "$for_status"; then
>> -		if [ -n "$files" ]; then
>> -			gettextln "Submodules changed but not updated:" | git stripspace -c
>> -		else
>> -			gettextln "Submodule changes to be committed:" | git stripspace -c
>> -		fi
>> -		printf "\n" | git stripspace -c
>> -		git stripspace -c
>> -	else
>> -		cat
>> -	fi
>> +	done
>>  }
>>  #
>>  # List all submodules, prefixed with:
>> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
>> index ac2434c..b435d03 100755
>> --- a/t/t7401-submodule-summary.sh
>> +++ b/t/t7401-submodule-summary.sh
>> @@ -262,19 +262,6 @@ EOF
>>  	test_cmp expected actual
>>  "
>>  
>> -test_expect_success '--for-status' "
>> -	git submodule summary --for-status HEAD^ >actual &&
>> -	test_i18ncmp actual - <<EOF
>> -# Submodule changes to be committed:
>> -#
>> -# * sm1 $head6...0000000:
>> -#
>> -# * sm2 0000000...$head7 (2):
>> -#   > Add foo9
>> -#
>> -EOF
>> -"
>> -

... and just remove the "# " from the expected output here. This
test can be removed when we use

>>  test_expect_success 'fail when using --files together with --cached' "
>>  	test_must_fail git submodule summary --files --cached
>>  "
>> diff --git a/wt-status.c b/wt-status.c
>> index 958a53c..d91661d 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -665,6 +665,10 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>>  	char index[PATH_MAX];
>>  	const char *env[] = { NULL, NULL };
>>  	struct argv_array argv = ARGV_ARRAY_INIT;
>> +	struct strbuf cmd_stdout = STRBUF_INIT;
>> +	struct strbuf summary = STRBUF_INIT;
>> +	char *summary_content;
>> +	size_t len;
>>  
>>  	sprintf(summary_limit, "%d", s->submodule_summary);
>>  	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
>> @@ -673,7 +677,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>>  	argv_array_push(&argv, "submodule");
>>  	argv_array_push(&argv, "summary");
>>  	argv_array_push(&argv, uncommitted ? "--files" : "--cached");
>> -	argv_array_push(&argv, "--for-status");

And the line above has to stay.

>>  	argv_array_push(&argv, "--summary-limit");
>>  	argv_array_push(&argv, summary_limit);
>>  	if (!uncommitted)
>> @@ -685,9 +688,31 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>>  	sm_summary.git_cmd = 1;
>>  	sm_summary.no_stdin = 1;
>>  	fflush(s->fp);
>> -	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
>> +	sm_summary.out = -1;
>> +
>>  	run_command(&sm_summary);
>>  	argv_array_clear(&argv);
>> +
>> +	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
>> +
>> +	/* prepend header, only if there's an actual output */
>> +	if (len) {
>> +		if (uncommitted)
>> +			strbuf_addstr(&summary, _("Submodules changed but not updated:"));
>> +		else
>> +			strbuf_addstr(&summary, _("Submodule changes to be committed:"));
>> +		strbuf_addstr(&summary, "\n\n");
>> +	}
>> +	strbuf_addbuf(&summary, &cmd_stdout);
>> +	strbuf_release(&cmd_stdout);
>> +
>> +	summary_content = strbuf_detach(&summary, &len);
>> +	strbuf_add_commented_lines(&summary, summary_content, len);
>> +	free(summary_content);
>> +
>> +	summary_content = strbuf_detach(&summary, &len);
>> +	fprintf(s->fp, summary_content);
>> +	free(summary_content);
>>  }
>>  
>>  static void wt_status_print_other(struct wt_status *s,

Junio already commented on this part.
