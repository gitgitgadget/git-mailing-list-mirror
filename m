From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 09/19] ls-files.c: use index api
Date: Wed, 17 Jul 2013 10:07:07 +0200
Message-ID: <87wqopsj84.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-10-git-send-email-t.gummerer@gmail.com> <CACsJy8DA=AD8=_kVYLNMS53fb8QwqKG4=8fA1cYAQBTn1gcj0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 10:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzMlj-0003j3-4y
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 10:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab3GQIHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 04:07:19 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:42289 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab3GQIHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 04:07:12 -0400
Received: by mail-ee0-f43.google.com with SMTP id l10so855332eei.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=O79M76hSFytmfx+EGwonbcC1T6YYNhOoV6yJCwbkUHE=;
        b=IosvGVXDfUAcWjEMQVHyZ3s8AneFxopTYceztynjfbnYb4iLbEuDQ5IRKhk7ySoB1U
         tkYsiQPmc+tvbQCMuQVSeU9uhJEJtsPUd6vXLMou/NQsQ1cTGzaF386tM06HawqwuMiv
         c5w1dr6WHy2Zt6BNuz1SrgcdVyruzRbsRTjdD+hkpCRfedVLnz/7jsHDxMGLxJ+bEGj7
         b9DE5V/9wakU8rELDhO470H3hGgQYAL5BdjtAeP5W4Fht4t4MzQJuaNkZQyZFmNjMDKB
         q87LbRV0yRKtbOKRQJB1dA6gas7PC+h0tAnDhVkhbCI0MUNZk40kHxYN07IB4ynr+C+M
         PoGA==
X-Received: by 10.15.64.68 with SMTP id n44mr5224818eex.73.1374048430432;
        Wed, 17 Jul 2013 01:07:10 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id o5sm8815882eef.5.2013.07.17.01.07.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 01:07:09 -0700 (PDT)
In-Reply-To: <CACsJy8DA=AD8=_kVYLNMS53fb8QwqKG4=8fA1cYAQBTn1gcj0Q@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230606>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +       if (!with_tree) {
>> +               memset(opts, 0, sizeof(*opts));
>> +               opts->pathspec = &pathspec_struct;
>> +               opts->read_staged = 1;
>> +               if (show_resolve_undo)
>> +                       opts->read_resolve_undo = 1;
>> +               read_cache_filtered(opts);
>
> So you load partial index here.
>
>> +       } else {
>> +               read_cache();
>> +       }
>> +       /* be nice with submodule paths ending in a slash */
>> +       if (pathspec)
>> +               strip_trailing_slash_from_submodules();
>
> Then strip_trailing_slash_from_submodules will attempt to convert
> pathspec "foo/" to "foo" if "foo" exists in the index and is a
> gitlink. But becaues "foo/" is used to load the partial index, "foo"
> is not loaded (is it?) and this could become incorrect no-op. I
> suggest you go through the pathspec once checking for ones ending with
> '/'. If so strip_trailing_... may potentially update pathspec, just
> load full index. If no pathspec ends with '/', strip_trail... is no-op
> and we can do partial loading safely.

It was loaded, because the adjusted_pathspec algorithm stripped the
trailing slash and then everything until the next slash.  That's
overkill except when the trailing slash had to be stripped.

I'll make the adjusted_pathspec algorithm more restrictive, so the last
trailing slash is no longer stripped.  If a pathspec contains a trailing
slash I'll load the whole index, as you suggested.
