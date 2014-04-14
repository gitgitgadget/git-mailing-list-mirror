From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] transport-helper: fix sync issue on crashes
Date: Mon, 14 Apr 2014 14:25:38 -0700
Message-ID: <xmqq38hfmwml.fsf@gitster.dls.corp.google.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
	<1397334812-12215-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:25:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZoNv-00064o-3K
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 23:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbaDNVZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 17:25:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954AbaDNVZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 17:25:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 864E07DFF6;
	Mon, 14 Apr 2014 17:25:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VXHM0coXyfkzPJU8ZbJorSdkJEQ=; b=CrqYCfXaA91jF3nLwryb
	k7vDG/++bx7YFbWlN5JeEZpbHlCt3K2+jwzhRDwirkf/7Oh74D9F+5PS1oBomo4k
	+1PqywdtAjugtgQ6MG/zgKcBde8hIE9lOi76nU6YajrZYtCcxvtE+RxZVkeLyon6
	i+GryVqVNxiVJFoaxTsx2SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=p0wg6Y3ltC/72B2Lf6/qhe/8NjJbgGVrtbBOc+blxe2CVn
	yC1A9HXRw/+KGNV983BB9dTZKNPhWhoxKsMegQb6WokNOKxw8RmAhwLp/SQLgbpT
	Pd4MtG84km+zphUZCal3hdzj2iCYo+m/bWE7DG2tRD5hmUGaecovl1HEalA9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E30A7DFF4;
	Mon, 14 Apr 2014 17:25:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E06577DFF2;
	Mon, 14 Apr 2014 17:25:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53BE89E0-C41B-11E3-8BD1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246268>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When a remote helper crashes while pushing we should revert back to the
> state before the push, however, it's possible that `git fast-export`
> already finished its job, and therefore has exported the marks already.
>
> This creates a synchronization problem because from that moment on
> `git fast-{import,export}` will have marks that the remote helper is not
> aware of and all further commands fail (if those marks are referenced).
>
> The fix is to tell `git fast-export` to export to a temporary file, and
> only after the remote helper has finishes successfully, move to the
> final destination.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This seems to be based on a somewhat older codebase; I tried to be
careful while adjusting the patch to the current codebase, but
please give it an eyeball to see if I didn't make any silly mistake
when I push today's integration result out in a few hours.

Thanks.

>  t/t5801-remote-helpers.sh | 17 ++++++++++++++++-
>  transport-helper.c        | 13 +++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 613f69a..cf7fd43 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -207,6 +207,17 @@ test_expect_success 'push update refs failure' '
>  	)
>  '
>  
> +clean_mark () {
> +	cut -f 2 -d ' ' $1 | git cat-file --batch-check | grep commit | sort > $(basename $1)
> +}
> +
> +cmp_marks () {
> +	test_when_finished "rm -rf git.marks testgit.marks" &&
> +	clean_mark .git/testgit/$1/git.marks &&
> +	clean_mark .git/testgit/$1/testgit.marks &&
> +	test_cmp git.marks testgit.marks
> +}
> +
>  test_expect_success 'proper failure checks for fetching' '
>  	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
>  	export GIT_REMOTE_TESTGIT_FAILURE &&
> @@ -221,7 +232,11 @@ test_expect_success 'proper failure checks for pushing' '
>  	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
>  	export GIT_REMOTE_TESTGIT_FAILURE &&
>  	cd local &&
> -	test_must_fail git push --all
> +	git checkout -b crash master &&
> +	echo crash >> file &&
> +	git commit -a -m crash &&
> +	test_must_fail git push --all &&
> +	cmp_marks origin
>  	)
>  '
>  
> diff --git a/transport-helper.c b/transport-helper.c
> index 2747f98..090c863 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -434,7 +434,7 @@ static int get_exporter(struct transport *transport,
>  	fastexport->argv[argc++] = data->signed_tags ?
>  		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
>  	if (data->export_marks) {
> -		strbuf_addf(&tmp, "--export-marks=%s", data->export_marks);
> +		strbuf_addf(&tmp, "--export-marks=%s.tmp", data->export_marks);
>  		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
>  	}
>  	if (data->import_marks) {
> @@ -901,7 +901,16 @@ static int push_refs_with_export(struct transport *transport,
>  
>  	if (finish_command(&exporter))
>  		die("Error while running fast-export");
> -	return push_update_refs_status(data, remote_refs);
> +	if (push_update_refs_status(data, remote_refs))
> +		return 1;
> +
> +	if (data->export_marks) {
> +		strbuf_addf(&buf, "%s.tmp", data->export_marks);
> +		rename(buf.buf, data->export_marks);
> +		strbuf_release(&buf);
> +	}
> +
> +	return 0;
>  }
>  
>  static int push_refs(struct transport *transport,
