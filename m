From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Mon, 21 Sep 2015 16:55:34 -0700
Message-ID: <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 01:55:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeAw9-0001La-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 01:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816AbbIUXzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 19:55:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33691 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687AbbIUXzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 19:55:36 -0400
Received: by pacex6 with SMTP id ex6so130284631pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 16:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nEeTamuzwJzwYDkgf1EDR3WK9dbj6mLZlbxOgF7/bVo=;
        b=gk4VbHhg/4ctytd93eswBe5wH1YKnGKnGgKFu8nvCji6gjvEbNBcVAAZ/we9t2Mfgo
         bLVJeYmgghfmM3mU8HRGwZh/8VpwAalk3dnAxLRNrfxuNUJHushe4+hIiQ5sTWMc2KE6
         RR0gPxl0YZA0v0Y8O76xdkUeH3uyybEAKcxDOTMEy0CkhY4NG7NIvOybO7jOViAcvtoC
         TVm+Zi9N67nO+qvWRwEMsLty7usAXoK6kRIlpqEY7ZjoqKVuj8SKUVHKCtiDDgqGrOPM
         nYTicwzzqidUjFZr+CMCpq+k5QB1vcH8gRUtCFdsaco6E6W14xI7Noohyzd4uMK3Y1bM
         Z/6w==
X-Received: by 10.68.102.225 with SMTP id fr1mr27981907pbb.65.1442879735663;
        Mon, 21 Sep 2015 16:55:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id xv12sm26856130pac.38.2015.09.21.16.55.34
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 16:55:35 -0700 (PDT)
In-Reply-To: <1442875159-13027-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278362>

Stefan Beller <sbeller@google.com> writes:

> So if we get an EAGAIN or EWOULDBLOCK error the fd must be nonblocking.
> As the intend of xread is to read as much as possible either until the
> fd is EOF or an actual error occurs, we can ease the feeder of the fd
> by not spinning the whole time, but rather wait for it politely by not
> busy waiting.

As you said in the cover letter, this does look questionable.  It is
sweeping the problem under the rug (the hard-coded 100ms is a good
clue to tell that).  If the caller does want us to read thru to the
end, then we would need to make it easier for such a caller to stop
marking the file descriptor to be non-blocking, but this does not do
anything to help that.  An alternative might be to automatically
turn nonblocking off temporarily once we get EAGAIN (and turn it on
again before leaving); that would be an approach to make it
unnecessary to fix the caller (which has its own set of problems,
though).

> +				if (i < 0) {
> +					if (errno == EINTR || errno == ENOMEM)
> +						continue;

I can sort of see EINTR but why is ENOMEM any special than other
errors?

> +					else
> +						die_errno("poll");
> +				}
> +			}
> +		}
>  		return nr;
>  	}
>  }
