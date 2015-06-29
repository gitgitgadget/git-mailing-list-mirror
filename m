From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/11] ref-filter: implement '--merged' and '--no-merged' options
Date: Mon, 29 Jun 2015 11:03:37 -0700
Message-ID: <xmqqegkubddy.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	<1435222633-32007-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:03:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dPE-0002xO-VL
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 20:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbbF2SDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 14:03:41 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36618 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbF2SDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 14:03:39 -0400
Received: by iecvh10 with SMTP id vh10so120611993iec.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kv/rp5+F7gjttPhuM/cJFeWLugdkWiqMcJhJC8Ox+os=;
        b=zDZHpiyxp+lY8JIaHXX94XdZZZ2xV/eTxIVz/azW7P3kfqq15EATF8OZrUqEWRhPc/
         2zg16Vay9AWCdDb2aBjshwDhQ4HGS2RG9U6Dnhj/HGMAPhcUYWvXsJ9jIO42tAvIRU2o
         xU/CtxBajnhOtYUMr6sd3SAiTqen/EJHSPksOySPR16i8EFixqOvxK75GGZ3r5I6ehvz
         ClVoUE5Lt45BB41hBnFcZrIEGsiNI6c91jOQfRsJWdWAcTz+RZboCl9EBBzLVmxEtfn3
         fcfLO/PiXrU5modhARD2BnXVPVGe7hEI373mQXAWk8MEqe+wSp+kqyFdFcibav+f/EEf
         N08w==
X-Received: by 10.107.164.196 with SMTP id d65mr23410951ioj.3.1435601018713;
        Mon, 29 Jun 2015 11:03:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id e10sm5943436igy.11.2015.06.29.11.03.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 11:03:38 -0700 (PDT)
In-Reply-To: <1435222633-32007-6-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 14:27:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272988>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
> +{
> +	struct rev_info revs;
> +	int i, old_nr;
> +	struct ref_filter *filter = ref_cbdata->filter;
> +	struct ref_array *array = ref_cbdata->array;
> +	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
> +
> +	init_revisions(&revs, NULL);
> +
> +	for (i = 0; i < array->nr; i++) {
> +		struct ref_array_item *item = array->items[i];
> +		add_pending_object(&revs, &item->commit->object, item->refname);
> +		to_clear[i] = item->commit;
> +	}
> +
> +	filter->merge_commit->object.flags |= UNINTERESTING;
> +	add_pending_object(&revs, &filter->merge_commit->object, "");
> +
> +	revs.limited = 1;
> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +
> +	old_nr = array->nr;
> +	array->nr = 0;
> +
> +	for (i = 0; i < old_nr; i++) {
> +		struct ref_array_item *item = array->items[i];
> +		struct commit *commit = item->commit;
> +
> +		int is_merged = !!(commit->object.flags & UNINTERESTING);
> +
> +		if (is_merged == (filter->merge == REF_FILTER_MERGED_INCLUDE))
> +			array->items[array->nr++] = array->items[i];
> +		else
> +			free_array_item(item);
> +	}
> +
> +	for (i = 0; i < old_nr; i++)
> +		clear_commit_marks(to_clear[i], ALL_REV_FLAGS);
> +	clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
> +	free(to_clear);
> +}

Did this come from somewhere else (e.g. tag -l or branch -l)?  If
so, you'd need a note similar to what you added in [02/11] to the
original.

I also have a feeling that compared to an implementation based on
paint_down_to_common(), including is_descendant_of(), this may be
less precise (e.g. it would be confused with clock skew that lasts
more than SLOP commits).  If we are inventing a new helper (as
opposed to moving an existing one), we'd probably be better off
doing a thin wrapper around paint_down_to_common() than calling
revision-walk machinery.
