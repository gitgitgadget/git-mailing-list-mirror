From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Tue, 07 Jul 2015 13:37:08 -0700
Message-ID: <xmqqbnfn3dsb.fsf@gitster.dls.corp.google.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165501.GB23503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:37:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCZcH-0001mK-F7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 22:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbbGGUhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 16:37:16 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35632 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866AbbGGUhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 16:37:13 -0400
Received: by igcqs7 with SMTP id qs7so41624725igc.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/sLKwSQpoBy9/rf/UKrRFkuMj64EEDAIUkqZnNPf8dQ=;
        b=pDFD+RZWPTWLeRRU2T49n3HMMss3JWHwY4OzzlcnU5lxn0diLGK+UCRMBKG6RQdyPD
         HmuAoWOx+PUmU8TLGTVFQG9E9iKGYH0LRo6XzZqushPcT9OnMBE+QU8t0nLSojbPP1tV
         CN+n1J2H4rxr9fYFsF7xR/yFlWU18S9CGLnkMqXuOSxviMKoqyzdGTJciDn90ujQqaWs
         19LEpsCBEDrf0OAYsafTbIVDdH6c8RHhYHBPA4b6Mg6AXNK55qfRaiMcSxJjln2g60d/
         EZ470mLv+oBJIva22wef0mtzFR0kNBrvPMNysWcPY0FwT3Pj5xltkbXX5ZLa7bhc8a+M
         5z7Q==
X-Received: by 10.50.7.68 with SMTP id h4mr55068957iga.40.1436301432809;
        Tue, 07 Jul 2015 13:37:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id 196sm245754ioe.23.2015.07.07.13.37.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 13:37:09 -0700 (PDT)
In-Reply-To: <20150625165501.GB23503@peff.net> (Jeff King's message of "Thu,
	25 Jun 2015 12:55:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273599>

Jeff King <peff@peff.net> writes:

> ...  However, the tricky case is where we use the
> enum labels as constants, like:
>
>   show_date(t, tz, DATE_NORMAL);
>
> Ideally we could say:
>
>   show_date(t, tz, &{ DATE_NORMAL });
>
> but of course C does not allow that.
> ...
>   3. Provide a wrapper that generates the correct struct on
>      the fly. The big downside is that we end up pointing to
>      a single global, which makes our wrapper non-reentrant.
>      But show_date is already not reentrant, so it does not
>      matter.
>
> This patch implements 3, along with a minor macro to keep
> the size of the callers sane.

Another big downside is that DATE_NORMAL is defined to be "0".

This makes it very cumbersome to merge a side branch that uses an
outdated definition of show_date() and its friends and tell them
to show date normally.  The compiler does not help detecting
places that need to be adjusted during merge and instead just pass
a NULL pointer as a pointer to the new struct.
