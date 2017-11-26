Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168462036D
	for <e@80x24.org>; Sun, 26 Nov 2017 08:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdKZINg (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 03:13:36 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:38933
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752053AbdKZINf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 03:13:35 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Is49eVTkAfgV3Is4CevZec; Sun, 26 Nov 2017 01:13:35 -0700
Date:   Sun, 26 Nov 2017 10:13:30 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171126081329.GD26158@jessie.local>
References: <20171126015448.24111-1-max@max630.net>
 <20171126015448.24111-2-max@max630.net>
 <xmqqo9npitx7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9npitx7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfB7d6kR3wNKeayChsWvtAdv2VZsvIme/hLEaFByFlCAkUSVqCYJN1RHge7XP43qbnhYWljX90iJc5gmvJqdTR6txdlxnF5+X9U8/SLPFEnnKVOtXdh1a
 M9FUbLXb9uxqlBrQ9UCAPjzp5tNgDYuEzVmG6NS+hFtns0lI89Rew8Ky4sD+sUldr4Zd3Jw/0+qmbfqnvmjiXK2/9+13W5RDrQL6LIsrqoYSVVV+uO2IPP7A
 fu6pJSJ6P88gUhW41KE+CQ3Y/x4/zf6hsVwc51T2aS+RFiB6lz8ccKOVN1kyVyrgmAb0xn5z/cn4xYwLpdMhisqaqbI2bK2NTU9noAEziP6nECCYpRdJfvze
 jI51MONSFaJM5/1ZNiZFMHfYeWrI+7Ulrz33lKkw9B+tveTgAWA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 12:46:12PM +0900, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> > +ssize_t git_env_ssize_t(const char *k, ssize_t val)
> > +{
> > +	const char *v = getenv(k);
> > +	if (v && !git_parse_ssize_t(v, &val))
> > +		die("failed to parse %s", k);
> > +	return val;
> > +}
> > +
> 
> If this were passing "v" that is a string the caller obtains from
> any source (and the callee does not care about where it came from),
> that would be a different story, but as a public interface that is
> part of the config.c layer, "k" that has to be the name of the
> environment variable sticks out like a sore thumb.
> 
> If we were to add one more public function to the interface, I
> suspect that exposing the existing git_parse_ssize_t() and have the
> caller implement the above function for its use would be a much
> better way to go.

I'm afraid I did not get the reasonsing and not fully the
desired change. Is this http-backend code change (compared
to the last patch) what you mean?

--- a/http-backend.c
+++ b/http-backend.c
@@ -346,9 +346,18 @@ static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **o
 	}
 }
 
+static ssize_t env_content_length()
+{
+	const char *str = getenv("CONTENT_LENGTH");
+	ssize_t val = -1;
+	if (str && !git_parse_ssize_t(str, &val))
+		die("failed to parse CONTENT_LENGTH: %s", str);
+	return val;
+}
+
 static ssize_t read_request(int fd, unsigned char **out)
 {
-	ssize_t req_len = git_env_ssize_t("CONTENT_LENGTH", -1);
+	ssize_t req_len = env_content_length();
 	if (req_len < 0)
 		return read_request_eof(fd, out);
 	else

