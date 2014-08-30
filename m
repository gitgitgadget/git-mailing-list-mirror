From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 19/19] signed push: fortify against replay attacks
Date: Sat, 30 Aug 2014 13:59:33 +0200
Message-ID: <5401BCA5.70502@gmail.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com> <1408739424-31429-20-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 13:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNhJp-0007cu-AR
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 13:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbaH3L7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 07:59:34 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:60674 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaH3L7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 07:59:33 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so3390836wib.0
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=3Q5+Yb7dawuDI1UuNluQmAIA7/CkxTC4DCVB+fj0jMk=;
        b=X0yS3P5IophRoEzEhZV/zju5YhNTylE/2NEW/QXV2db596KG5C5kbzOqBAEgxxqnI4
         7IA5hopbxBrv4VBaWrR9xNQAWuognU+E/A2gZMPNqsqyzUoVXAlB9cBV1OM1Gd2QFX7/
         ceH/gtyW7ktdw29LXxxdmeGGyJl0eImqd6HyVet1rm6A1R4LK8LMXtnfQz5yWJl0fbDi
         a/XOD27HaBx66gPV5nE7EVAUuMfqXHD777wmm8W56NaJ+JDayBV8A1cNkkiFVpbUswtq
         x5S0RqN7O/L+YRDGaMGk5jkfO5lmcdV1qNRJUMuh/SXacF+6B5jNLkdiQlFeelsnt9+3
         r33w==
X-Received: by 10.180.93.8 with SMTP id cq8mr9905663wib.17.1409399971608;
        Sat, 30 Aug 2014 04:59:31 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id r8sm4300842wjy.20.2014.08.30.04.59.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 04:59:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1408739424-31429-20-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256249>

On 22.08.2014 22:30, Junio C Hamano wrote:
> @@ -1226,12 +1232,28 @@ static int delete_only(struct command *commands)
>  	return 1;
>  }
>  
> +static char *prepare_push_cert_nonce(const char *sitename, const char *dir)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	unsigned char sha1[20];
> +
> +	if (!sitename) {
> +		static char buf[1024];
> +		gethostname(buf, sizeof(buf));
> +		sitename = buf;
> +	}
> +	strbuf_addf(&buf, "%s:%s:%lu", sitename, dir, time(NULL));
> +	hash_sha1_file(buf.buf, buf.len, "blob", sha1);
> +	return xstrdup(sha1_to_hex(sha1));
> +}
> +

On every other use of gethostname within git.git we're
checking the return code. And if gethostname fails, we're
either copying in 'localhost' or 'unknown' instead.

Does that make sense here as well?

Found by coverity scan.

Thanks,
Stefan
