From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Thu, 18 Jun 2015 09:46:09 -0700
Message-ID: <xmqqioalezhq.fsf@gitster.dls.corp.google.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
	<CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
	<CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
	<20150617191235.GB25304@peff.net> <20150618101353.GA6525@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cxF-0000WX-PW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbFRQqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 12:46:13 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35316 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbFRQqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:46:11 -0400
Received: by igbzc4 with SMTP id zc4so131593911igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3zsCyI6NvyeOWFfng9QQpKYgEwKxw9bh9KrdoyTYJ9w=;
        b=XG/XOQ9YX0Md/+EGijs0fRSmWsDVJQOXTa98eos54fGvt6V0aYeMuBHLWbjAtQJV0g
         z2BJNc3wP2bQOEKEXK5t0JwfdVgYG6OVPTsr4d1ekY1qm99ohLNjR1YBl0v/pBV1S/i5
         KGl1hsBgmVhAIyU+MAw9KLSeyLXujXynSWCr2iLHpXCA6bjLykcIWQ1npzfycfDFJrzl
         2/a4vlhH6ksEMoqpkb7bt1UGCAr8RuM8KlyQUHZSWiIM4PnBnGZz54MorHZPf3lUIUq0
         5OlN95ClQAUTn28sQ8lGju3Zwg4QelGjsk63ox5FNapkGJEMtbRpWejLCT+1eSXSxjaQ
         HjpQ==
X-Received: by 10.107.15.40 with SMTP id x40mr16546833ioi.0.1434645971057;
        Thu, 18 Jun 2015 09:46:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id k16sm14612978igf.19.2015.06.18.09.46.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 09:46:10 -0700 (PDT)
In-Reply-To: <20150618101353.GA6525@lanh> (Duy Nguyen's message of "Thu, 18
	Jun 2015 17:13:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272027>

Duy Nguyen <pclouds@gmail.com> writes:

> The last resort is simply filter out a whole class of warnings.
> Probably good enough if both patches look equally ugly.
>
> -- 8< --
> Subject: [PATCH] strbuf: kill strbuf_slopbuf, in favor of ""
>
> A lot of "out-of-bound access" warnings on scan.coverity.com is because
> it does not realize this strbuf_slopbuf[] is in fact initialized with a
> single and promised to never change. But that promise could be broken if
> some caller attempts to write to strbuf->buf[0] write after STRBUF_INIT.
>
> We really can't do much about it. But we can try to put strbuf_slopbuf
> in .rodata section, where writes will be caught by the OS with memory
> protection support. The only drawback is people can't do
> "buf->buf == strbuf_slopbuf" any more. Luckily nobody does that in the
> current code base.
> ---

Hmph, would declaring slopbuf as "const char [1]" (and sprinkling
the "(char *)" cast) have the same effect, I wonder?

> +static inline void strbuf_terminate(struct strbuf *sb)
> +{
> +	if (sb->buf[sb->len])
> +		sb->buf[sb->len] = '\0';
> +}

This is so that you can call things like strbuf_rtrim() immediately
after running strbuf_init() safely, but I think it needs a comment
to save people from wondering what is going on, e.g. "this is not an
optimization to avoid assigning NUL to a place that is already NUL;
a freshly initialized strbuf points at an unwritable piece of NUL
and we do not want to cause a SEGV".
