From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Tue, 23 Jun 2015 22:32:08 -0700
Message-ID: <xmqqegl1brjb.fsf@gitster.dls.corp.google.com>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
	<xmqqpp4maww7.fsf@gitster.dls.corp.google.com>
	<20150623232921.GB14324@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, torvalds@linux-foundation.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 24 07:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7dII-0001Nz-7i
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 07:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbbFXFcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 01:32:13 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37100 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbFXFcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 01:32:11 -0400
Received: by igblr2 with SMTP id lr2so26839805igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HwgGuLGTLVyOZCIUb6ZsKRQf5BP5WeKZ5ebSSwTW9lg=;
        b=Lb4HVxfvnYGrUCl4Bv6DT1SkO6JBRBczhebv01ilgPPwvljumfEKa/W6HIsq4L7QJr
         Lh57Z360LioY8kwK2CJwk6SWrn6mVUHMsmP9NIHgh4O+VbRh4LN0xk0uItofKzNyu9q0
         G7xo/llrWiaJ2aqMRRpXwNbg5RdUV8Gf1wJtAjOnE1sPvkOb4T6f2bdhbUJKzd3jGJWm
         c8I9jN1l4ob0/dUyBDhKuSUCfgqMaJI3W4/Ghz+kwhbos30JFg2q7brcIq7YiBGRL4dn
         /BVbOL0lnw1stZUAoGuK4b7XScxUAerX/IyuQq6TASBN9bhBjDQZvHFzFcHK06hD4mF0
         Y2Og==
X-Received: by 10.43.10.194 with SMTP id pb2mr36440676icb.31.1435123930779;
        Tue, 23 Jun 2015 22:32:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id d96sm9863144ioj.37.2015.06.23.22.32.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 22:32:10 -0700 (PDT)
In-Reply-To: <20150623232921.GB14324@thunk.org> (Theodore Ts'o's message of
	"Tue, 23 Jun 2015 19:29:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272532>

Theodore Ts'o <tytso@mit.edu> writes:

> The main issue is that non-expert users might not realize that they
> really need to run "git fsck" after a crash; otherwise, what might
> happen is that although git is only appending, that you might have
> some zero-length (or partially written) git object or pack files, and
> while you might not notice at that moment, it might come and bite you
> later.

Regarding loose object files, given that we write to a temporary,
optionally fsync, close and then move to the final name, would we
still see partially written file if we omit the fsync, or would the
corruption be limited to either empty or missing?

The reason I am wondering is because the codepath to create an
object (i.e. "update-index --add", "hash-object -w", or "add") first
checks if a packed or a loose object file _exists_ and if so
bypasses writing the same thing anew, but the existence check for a
loose object is to merely making sure that access(F_OK) (and
optionally utime()) succeeds.  If the potential breakage is limited
to truncation to empty, then we could replace it with stat(2) and
st.st_size check, as no loose object file can be empty.
