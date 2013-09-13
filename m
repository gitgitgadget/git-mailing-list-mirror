From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] name-hash: refactor polymorphic index_name_exists()
Date: Fri, 13 Sep 2013 18:20:17 -0400
Message-ID: <CAPig+cR8oYcp1ERUtW7wUvjFN0j0921iBOUjYKor59gTOb+Zcw@mail.gmail.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
	<1379070943-36595-2-git-send-email-sunshine@sunshineco.com>
	<xmqq38p8k1kf.fsf@gitster.dls.corp.google.com>
	<CAPig+cQxvHPbxy9YE7qYTVEXy1JCXkmBi48QrkL=bvhKRgryuQ@mail.gmail.com>
	<CAPc5daVtDByrA6yakk_1fq9g5Hv3naNDzEho5G4Ghxc6jzpawg@mail.gmail.com>
	<CAPig+cS4x1h3v2=0T95+g2_08_7qZj7fUsSiLgDtFyRSbFE0bA@mail.gmail.com>
	<xmqqfvt8iczh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbix-0002Cw-CF
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab3IMWUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:20:20 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:39902 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3IMWUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:20:18 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1560250lab.28
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=O6czu1HL6QtEbkCXBO72gIm/dolO96bKW+EB2GABYSA=;
        b=CISmBiis10oWdZ4DCO3PaxcwThQJUmexQbfQhjFiLUqNSff/GFYM9qGQ6tokjGUKwY
         YOH6FJdfDx8y06lZEnTUdnDOlOKgWF+XsOGQiRLrHeRkiwRIhaeSujscu/atV6vNBZKo
         pg3VeH1xn7bsNWKtl7ywFELkV1wgszy4SQ95zNCztLNdWcO2e0+3FuASnjxCe9UiiBa3
         dnFTa5nEKOdBbs2nxJDKNrWyKSeHrss3lrdm6AjnqMKUEG40MiTLW5EAFYv7pebVtQNW
         drZpEpmnNTqyn4oKxjxCJpM2rkYzLV6s26GnSA0zlU/INOzk7IDUqDXwdSuMoEeDcoO9
         sT4A==
X-Received: by 10.112.167.3 with SMTP id zk3mr13497787lbb.23.1379110817534;
 Fri, 13 Sep 2013 15:20:17 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 13 Sep 2013 15:20:17 -0700 (PDT)
In-Reply-To: <xmqqfvt8iczh.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: xviuMKsTF9u0D2JiaozYH1hiQNY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234779>

On Fri, Sep 13, 2013 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Given the above. How should I proceed? Do you still feel that it is
>> advisable to keep an index_name_exists() around for compatibility
>> reasons in case any new callers are introduced? Regardless of that
>> answer, do you want index_name_exists() renamed to
>> index_file_exists()?
>
> Renaming *_name_exists() to *_file_exists() without keeping a
> compatibility one will force new topics to be rebased on this
> series.  Alternatively we could merge them to 'pu' (and later 'next'
> and 'master') with evil merges to adjust the change in the semantics
> of the called function.  That increases the risk of accidental
> breakages, I think.
>
> It is safer to keep index_name_exists() around with the older
> semantics, if we can, and rename your "file only" one to a different
> name.  That way, even if a new topic still uses index_name_exists()
> expecting the traditional behaviour, it will not break immediately
> and we do not need to risk evil merges making mistakes.
>
> Later, we can "git grep _name_exists" to spot them and convert such
> old-style calls to either "directory only" or "file only" variants
> after this series and these follow-on topics hit 'master' (and we do
> not know at this point in what order that happens).

Thanks. That's what I needed to know. I'll re-roll with the suggested changes.

(And, I'm looking into the Mac-only test breakages not related to this
patch series.)
