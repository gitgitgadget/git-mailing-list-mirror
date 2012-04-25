From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/30] Read loose references lazily
Date: Wed, 25 Apr 2012 11:39:02 -0700
Message-ID: <xmqqbomfd5bt.fsf@junio.mtv.corp.google.com>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 25 20:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN77O-0004Kr-SM
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 20:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab2DYSjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 14:39:05 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:41420 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2DYSjE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 14:39:04 -0400
Received: by qabg24 with SMTP id g24so189741qab.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 11:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=SiT2Dm5zjB3y+2ye0rByTRf01j/WbpzR77ik3gLYJHI=;
        b=U7pXSe8ZjH/EkR6Acvv2A1XgSNTMhUq8AXq7BRSh91a7bONwfnFKhczo7nN7nMRgHh
         UNObEowP+dt9TUSmICTlGfF+8DYAIfWCsdZn6DNfJhWf2QOFmNk8YlNPWb68gKfkYIa7
         wPskt0TJ1zblZFLDQ+WohbK9UhevVlnc/QFdJ4TeWeCI2XbiJMuFAgC8v+YihJGKF/5n
         Ek0UW9DgujaFkoq2qmp2YqM2oBgR+VjaM1n4tUwuJ/WjlpUAbVjKkKMs3KakC119M0ZZ
         MR+Pzl2dgKETS7QdDMeWQfQhv/B4ceonC91eY75aeO4/qveog4dyy5vaeMJ5es+gkaJ7
         CVrg==
Received: by 10.100.76.4 with SMTP id y4mr1309714ana.21.1335379143107;
        Wed, 25 Apr 2012 11:39:03 -0700 (PDT)
Received: by 10.100.76.4 with SMTP id y4mr1309686ana.21.1335379142918;
        Wed, 25 Apr 2012 11:39:02 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d65si468050yhn.3.2012.04.25.11.39.02
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 11:39:02 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id CA38E100052;
	Wed, 25 Apr 2012 11:39:02 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 746E5E125C; Wed, 25 Apr 2012 11:39:02 -0700 (PDT)
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
	(mhagger@alum.mit.edu's message of "Wed, 25 Apr 2012 00:45:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkAVCM3wGRB8s2gXP+SyXgjLv88Gh8zR7Pewca6i+GwzhrPKGEMVnHbmKW4NojJuQn68Mgn95iVY/P8ZU/o/E0Y7WKAe1blcHDvfOnDx9sd0YMd4YEutR98Umpdvjd8fG8vkD1eJnTlwM3wkCjBlVpQ0L5aBnCBLhrjfrtfoR8O4Ni1pr4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196329>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> This is the next installment of the ref-api saga.  The main result of
> this patch series is to teach git to read loose references one
> directory at a time, only when they are needed.
>
> The first nine commits are not very interesting; they convert
> get_ref_dir() and do_for_each_reflog() to use strbufs and to tighten
> up their specifications.  The search_for_subdir() function extracted
> in patch 5 will be useful later.  Patch 6 slightly reduces the amount
> of work needed to read loose refs from disk, and also changes the
> function's API in a way that will be needed later when directories are
> read one at a time.
>
> Patches 10 - 25 mostly switch a lot of code from using ref_dir
> pointers to using ref_entry pointers as arguments and return values.
> This is important, because ...

The earlier parts looked sane, but the ref_dir set of patches looked
like merely working around the fact that "struct ref_dir" does not have
the name field and you had to upcast it to ref_entry to access the full
name.

All the places that used to take ref_dir never wanted to get an entry
that represents a leaf node (i.e. ref_value kind of ref_entry), but now
because you made everybody to take ref_entry, the resulting code is much
more error prone and the static type checking done by the compiler helps
us much less when updating the code.  It can already be seen that you
had to sprinkle a lot of assert(flag & REF_DIR), but at runtime in
non-debug build that will become no-op and it is not a substitute for
the static type checking we used to have.

Can't we approach this differently so that we can keep the type safety?
