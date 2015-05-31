From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make them public
Date: Sun, 31 May 2015 10:48:55 -0700
Message-ID: <xmqqmw0kab94.fsf@gitster.dls.corp.google.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:49:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7ME-0001rh-Cf
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbbEaRs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:48:59 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34879 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381AbbEaRs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:48:58 -0400
Received: by iesa3 with SMTP id a3so94756521ies.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qpENLlqmKrPYvKWukpAnUS2aZc3EGqjj7YHNmiTX6oM=;
        b=tjnc7BFWI3TSRoNARue6ccNV2lP3YRY21sKAU9tlYYt60CrEJjk+h7C/OUo0to4vsl
         O4cepiq/N2fz+HhSTQzK6iWWCE2zwrnNTUBb0ZHOe9LLPqz0ePNGj4VzRcrWYaMWfRdy
         MsKde/nyaeFj5NjGRN2Ay272C5PftPuH32grLs6ct2XnS/1qWmK/Mr7inzR/bG3mNHLQ
         F1NCCqknzfMAJ3v00JCG4J2tvql37M1gYpFmC5W4LTDAUdWa5T+bftI4No+ifLgA8XGH
         7VZteh8D1O5v9ORRf3kxb0Yjt4m3e+ctwGglBENW1HHZAwgY+PWGl8MnJEKl1swzwjZo
         B6ng==
X-Received: by 10.107.7.84 with SMTP id 81mr21695352ioh.28.1433094536613;
        Sun, 31 May 2015 10:48:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3d1d:5ddf:1454:826b])
        by mx.google.com with ESMTPSA id k74sm8735118iok.30.2015.05.31.10.48.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 31 May 2015 10:48:55 -0700 (PDT)
In-Reply-To: <1433008411-8550-6-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 30 May 2015 23:23:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270338>

Karthik Nayak <karthik.188@gmail.com> writes:

>  /*
> - * A call-back given to for_each_ref().  Filter refs and keep them for
> + * A call-back given to for_each_ref(). Filter refs and keep them for
>   * later object processing.
>   */
> -static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
> +int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {

I am not sure if this is a good external interface, i.e. to expect
callers of ref-filter API to do this:

	prepare cbdata;
	for_each_ref(ref_filter_handler, &cbdata);

It might be better to expect callers to do this instead:

	prepare cbdata;
        filter_refs(for_each_ref, &cbdata);

i.e. introducing a new "filter_refs()" function as the entry point
to the ref-filter API.  The filter_refs() entry point may internally
use ref_filter_handler() that will be file-scope static to ref-filter.c
and at that point the overly generic "-handler" name would not bother
anybody ;-) but more importantly, then you can extend the function
signature of filter_refs() not to be so tied to for_each_ref() API.
It could be that the internals of cbdata may not be something the
callers of filter-refs API does not even have to know about, in
which case the call might even become something like:

	struct ref_array refs = REF_ARRAY_INIT;
        const char **ref_patterns = { "refs/heads/*", "refs/tags/*", NULL};

	filter_refs(&refs, for_each_rawref, ref_patterns);

        /* now "refs" has the result, the caller uses them */
	for (i = 0; i < refs.nr; i++)
        	refs.item[i];

Just a thought.
