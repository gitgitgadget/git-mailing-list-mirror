From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/11] Port tag.c over to use ref-filter APIs
Date: Mon, 03 Aug 2015 13:21:52 -0700
Message-ID: <xmqq8u9s86n3.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMMFD-0004qu-Ep
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 22:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbbHCUVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 16:21:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36172 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbbHCUVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 16:21:54 -0400
Received: by pacgq8 with SMTP id gq8so32433493pac.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IabLgPwoDzOp8z0NM135ATofrQovVWXeyxUctnekQ9s=;
        b=XMlb3TKViyO2+9COm9ATzoEx2h2Rbw7DvuxN9Cjt/llhHtgc3OnFih2EAjODtJiREw
         JTOorML9nbVo6KkMid0Khnd9TeJlVo6xr93yLmzpLCyF89OzSHCyLEKDXwLSpFszGjfL
         BU/zIYK+/FcAkd9xiGqEBAfpr0vj3DzP7gvn6vVZjUHFj3Zlw32nrZCghLBbEaNteSU6
         qH2geL2bMfd1hOXz3qJVucdh0gI6qL3OBCIn8DdIL+ZST3gZh+aCSwFFhSx+Uzk0zNYm
         5JY2efUnLU/KjsNVSBBHEJbqlbxIoGBsLhgLXNjPGp+Fw+1ByFzq5ro7sCepixS81t2u
         9pqg==
X-Received: by 10.66.119.136 with SMTP id ku8mr38400854pab.26.1438633314078;
        Mon, 03 Aug 2015 13:21:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id np15sm18494864pdb.1.2015.08.03.13.21.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 13:21:53 -0700 (PDT)
In-Reply-To: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 3 Aug 2015 22:22:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275194>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is part of my GSoC project to unify git tag -l, git branch -l,
> git for-each-ref.  This patch series is continued from: Git (next)
> https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61
>
> This series consists of porting tag.c over to using the ref-filter APIs
>
> Version 7 can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/274990
>
> Changes:
> * Make padright a general align atom.
> * Make print_value() and emit() output to a strbuf rather than stdout directly.
>
> Interdiff:
>
> diff --git a/Documentation/git-for-each-ref.txt
> b/Documentation/git-for-each-ref.txt
> index bcf319a..e89b9b0 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,11 +127,12 @@ color::
>      Change output color.  Followed by `:<colorname>`, where names
>      are described in `color.branch.*`.
>
> -padright::
> -    Pad succeeding atom or string to the right. Followed by
> -    `:<value>`, where `value` states the total length of atom or
> -    string including the padding. If the `value` is lesser than
> -    the atom or string length, then no padding is performed.
> +align::
> +    Align succeeding atoms to the right, left or middle. Followed
> +    by `:<type>,<paddinglength>`, where the `<type>` is either
> +    left, right or middle and `<paddinglength>` is the total
> +    length of the padding to be performed. If the atom length is
> +    more than the padding length then no padding is performed.

It is very very dissapointing to allow the "next atom only"
implementation to squat on a good name "align:<type>,<width>",
especially when I thought that the list agreed

  %(align:<type>,<width>) any string with or without %(atom) %(end)

would be the way to go.
