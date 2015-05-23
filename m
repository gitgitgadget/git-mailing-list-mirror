From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Sat, 23 May 2015 23:22:51 +0530
Message-ID: <5560BE73.8020801@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com>	<vpqbnhd157k.fsf@anie.imag.fr> <555F252C.2060601@gmail.com> <vpq8ucffj8h.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 23 19:53:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwDba-0004fr-33
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbbEWRw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:52:56 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33024 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbbEWRw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:52:56 -0400
Received: by padbw4 with SMTP id bw4so42770640pad.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9cnk4iD+GKgEvs00Qb2KO4v2MGat59jJzaQ4hGWp6+E=;
        b=lQ54LcHoJvVyo8n2fHAsGnQy00eF9OpKNlW/EEUSut29YgJ+r9lJF0olhKT5qIZJJq
         VRYx9a6TaC/bTcypFy1eljBHea7n9sRqj0XmA7qkR9ptsup95Kfq2HgxLWQnem7e2eJI
         bYepnlZr4kagpWoNCS5ZxGEbSFRN10NrKa3xX9AgRbRiLKjcXx2SX2Yp3dZOLe4a6z0l
         gWxDrne145ju4uxTy/XPSg1o4njVO0mcdCCJYBqzirBudnV+i1TcFA6pZwxkApT+ssi7
         hcu0LAVWS8F7mm7TLmVGA8aDpaqgS8vnXKBsJMWQ5Y7rdj/Rbv+AV2BPdScFplasPRWF
         tw5Q==
X-Received: by 10.68.57.229 with SMTP id l5mr26149015pbq.130.1432403575517;
        Sat, 23 May 2015 10:52:55 -0700 (PDT)
Received: from [192.168.0.105] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ph4sm5499175pdb.43.2015.05.23.10.52.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 May 2015 10:52:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq8ucffj8h.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269813>

>
> But it also contains struct ref_filter_item **items, which as I
> understand it contains a list of refs (with name, sha1 & such).
>
> That's the part I do not find natural: the same structure contains both
> the list of refs and the way it should be filtered.
>
> Re-reading the patch, I seem to understand that you're putting both on
> the same struct because of the API of for_each_ref() which takes one
> 'data' pointer to be casted, so you want both the input (filter
> description) and the output (list of refs after filtering) to be
> contained in the same struct.

Was kinda confused, This clears out things, Thanks.

>
> But I think this could be clearer in the code (and/or comment + commit
> message). Perhaps stg like:
>
> struct ref_filter_data /* Probably not the best name */ {
>          struct ref_list list;
>          struct ref_filter filter;
> };
>
> struct ref_list {
>   	int count, alloc;
>   	struct ref_filter_item **items;
>   	const char **name_patterns;
> };
>
> struct ref_filter {
> 	const char **name_patterns;
> 	/* There will be more here later */
> };
>

This seems cleaner, agreed.

 >
 > I agree that it might be clearer to separate both. In this case
 > instead of "ref_list" the struct might be called "ref_filter_array" as
 > we already have "argv_array" in argv-array.h and "sha1_array" in
 > "sha1-array.h".
 >

Somehow ref_list seems more real to me, list of refs.

 >
 > And I do not think an array of things that are operated on should
 > not be named "ref_filter_item".
 >
 > Surely, the latter "set of operations to be applied" may currently
 > be only filtering, but who says it has to stay that way?  "I have a
 > set of refs that represent my local branches I am interested
 > in. Please map them to their corresponding @{upstream}" is a
 > reasonable request once you have an infrastructure to represent "set
 > of refs to be worked on" and "set of operations to apply", and at
 > that point, the items are no longer filter-items (map-items?).
 >

That's also a good point to consider, I shall rename and restructure the 
code as discussed here, thanks.

-- 
Regards,
Karthik
