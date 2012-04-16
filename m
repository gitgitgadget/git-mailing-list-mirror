From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/7] Add output_prefix_length to diff_options
Date: Mon, 16 Apr 2012 11:48:36 -0700
Message-ID: <7vsjg3tsvv.fsf@alter.siamese.dyndns.org>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
 <1334573095-32286-3-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJqyi-0001ef-B4
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 20:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab2DPSsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 14:48:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869Ab2DPSsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 14:48:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 505BF62AE;
	Mon, 16 Apr 2012 14:48:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=R6q1FtvEuv8UxzZ92tGVtwQcTnc=; b=UOp5B6xvQUM4g0pvicJA
	MMBim6A6KCQ9vIadOl0buPQTMHa+hnoz2QriOIhiEjbUZsQAhaoSrIAGTmKq4fXQ
	FUS3zXUOSjG9c6Wu3pVWiyg59n+jcSYemiMCUfOCEvDnn+eFmn0Ixn937pAKkG44
	MsC/rIw0qNdBKhK+3BA9YUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ea4cG2gPHmCvmY0IXPIoaDk6FqNVF9mAx0Sq2Hb4rc4QDc
	1sJdhdgpkd8zyKfLWN8hU48qyGM2VYdYGMHT5NWHAETvgKmRla/zKsRSUSAlRSnm
	XSylVe0zTcRXJxgtR//NWLXUdNksanqwhNIlCTeEI6vJ7tELIhmbTUFbpiVVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47DF262AC;
	Mon, 16 Apr 2012 14:48:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB21862AB; Mon, 16 Apr 2012
 14:48:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7026CC4-87F4-11E1-BFE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195679>

Lucian Poston <lucian.poston@gmail.com> writes:

> Add output_prefix_length to diff_options. Initialize the value to 0 and only
> set it when graph.c:diff_output_prefix_callback() is called.
>
> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---
>  diff.h  |    1 +
>  graph.c |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)

This patch is a no-op, as nobody pays attention to the value this field
contains.  I think it is better to squash this with 3/7 where you
introduce the only user of this field.

Also when that happens, you would need to adjust the test vector, which
may mean that you need to squash the result with 4/7 as well.

> diff --git a/diff.h b/diff.h
> index cb68743..19d762f 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -150,6 +150,7 @@ struct diff_options {
>  	diff_format_fn_t format_callback;
>  	void *format_callback_data;
>  	diff_prefix_fn_t output_prefix;
> +	int output_prefix_length;
>  	void *output_prefix_data;
>  };
>  
> diff --git a/graph.c b/graph.c
> index 7358416..7e0a099 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -194,8 +194,10 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
>  	struct git_graph *graph = data;
>  	static struct strbuf msgbuf = STRBUF_INIT;
>  
> +	assert(opt);
>  	assert(graph);
>  
> +	opt->output_prefix_length = graph->width;
>  	strbuf_reset(&msgbuf);
>  	graph_padding_line(graph, &msgbuf);
>  	return &msgbuf;
> @@ -245,6 +247,7 @@ struct git_graph *graph_init(struct rev_info *opt)
>  	 */
>  	opt->diffopt.output_prefix = diff_output_prefix_callback;
>  	opt->diffopt.output_prefix_data = graph;
> +	opt->diffopt.output_prefix_length = 0;
>  
>  	return graph;
>  }
