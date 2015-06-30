From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 06/11] ref-filter: implement '--merged' and
 '--no-merged' options
Date: Tue, 30 Jun 2015 19:08:00 +0530
Message-ID: <CAOLa=ZSqvtXioRzeekjCAL3HoFsQmaLKQF=9YmftjQasiHvpqg@mail.gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com> <1435222633-32007-6-git-send-email-karthik.188@gmail.com>
 <xmqqegkubddy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 15:38:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9vkB-0001vz-CX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 15:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbbF3Nia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 09:38:30 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33303 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbF3Ni3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 09:38:29 -0400
Received: by obpn3 with SMTP id n3so6547936obp.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wBen3dmi8TnDlcsGuO+TzlT9apHErMhuceCLSvwHnMg=;
        b=TZ/oFfoeFvRp6oaDEsAqk5x5QRbx/I1I5gGGG5+k7nMq+btIsRyUJGh6ZrmlfEieeP
         fATOK0LrdZoW9Kn1SKkMGiZ+x5H5CaZc4ZtTezQaVZidYNAozFiLUh5SNe6hGLM9ikbL
         npFAbseljsyMCU8ztZHnCwifOFkeNpS1qNk2bpuPQ9nLupE1Xcx+19WnI1JtkuNsPsIt
         kVuFCmOfKZxQ5vbb3CbTbcmwFG8RoTd/B6i0X5DLmJZqG27DtaSJD6xDhIwarVJsTQ8O
         FNogNQqIUNUV8/1XVwEFJNzuxmeM6ZFDdv9hoEpKbwysfyE6qrpHECDbdHH+JfvPddEt
         xGow==
X-Received: by 10.182.153.161 with SMTP id vh1mr16164042obb.34.1435671509433;
 Tue, 30 Jun 2015 06:38:29 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 30 Jun 2015 06:38:00 -0700 (PDT)
In-Reply-To: <xmqqegkubddy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273063>

On Mon, Jun 29, 2015 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>> +{
>> +     struct rev_info revs;
>> +     int i, old_nr;
>> +     struct ref_filter *filter = ref_cbdata->filter;
>> +     struct ref_array *array = ref_cbdata->array;
>> +     struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
>> +
>> +     init_revisions(&revs, NULL);
>> +
>> +     for (i = 0; i < array->nr; i++) {
>> +             struct ref_array_item *item = array->items[i];
>> +             add_pending_object(&revs, &item->commit->object, item->refname);
>> +             to_clear[i] = item->commit;
>> +     }
>> +
>> +     filter->merge_commit->object.flags |= UNINTERESTING;
>> +     add_pending_object(&revs, &filter->merge_commit->object, "");
>> +
>> +     revs.limited = 1;
>> +     if (prepare_revision_walk(&revs))
>> +             die(_("revision walk setup failed"));
>> +
>> +     old_nr = array->nr;
>> +     array->nr = 0;
>> +
>> +     for (i = 0; i < old_nr; i++) {
>> +             struct ref_array_item *item = array->items[i];
>> +             struct commit *commit = item->commit;
>> +
>> +             int is_merged = !!(commit->object.flags & UNINTERESTING);
>> +
>> +             if (is_merged == (filter->merge == REF_FILTER_MERGED_INCLUDE))
>> +                     array->items[array->nr++] = array->items[i];
>> +             else
>> +                     free_array_item(item);
>> +     }
>> +
>> +     for (i = 0; i < old_nr; i++)
>> +             clear_commit_marks(to_clear[i], ALL_REV_FLAGS);
>> +     clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
>> +     free(to_clear);
>> +}
>
> Did this come from somewhere else (e.g. tag -l or branch -l)?  If
> so, you'd need a note similar to what you added in [02/11] to the
> original.
>

Will do this, thanks.

> I also have a feeling that compared to an implementation based on
> paint_down_to_common(), including is_descendant_of(), this may be
> less precise (e.g. it would be confused with clock skew that lasts
> more than SLOP commits).  If we are inventing a new helper (as
> opposed to moving an existing one), we'd probably be better off
> doing a thin wrapper around paint_down_to_common() than calling
> revision-walk machinery.
>

I'll have a look and get back to you.

-- 
Regards,
Karthik Nayak
