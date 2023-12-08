Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TzTEQslY"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6E10E0
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:17:22 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f59fcb204so28745085a.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702073842; x=1702678642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkKH6MBUdd81/sBubh5fzbYcDyMfrJdn5QXVQzRvE/g=;
        b=TzTEQslYkMDyPY8ZkTt7flwn0EnTNWPcMkhsPYRiaKTzgJiJFwTiY78aoIfCy7/7sG
         pKnXR0jvvlzZh7egDxhYI1RWKrDyW94G36FENeBih8n/Ov/g/vCdMw591Z3vKTeyeRA8
         24i+EeRfJwRDjxDY0ntr7WosDtS7C//zXJD7VE+Yv5poJm2t8EXnBdxh2PMlOvFEy/cc
         poMCy3FUe7dF5HKuHetSfd1qHSRZo9S0ko17yKcJoaaEa7lTY7G75o4oPA9Bs0WT2CjL
         3f7ICdltpBL+bhKYkrGauPXqlJn0C3TqlRRsjHjacl/rO3k5Iu8j/GNm8Yya9C7QvyOK
         Olrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073842; x=1702678642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkKH6MBUdd81/sBubh5fzbYcDyMfrJdn5QXVQzRvE/g=;
        b=AzyNWP9sIO+Gxb6BnDDyyp3yNmha42bcrwVt0yJE7z2b271s/hT6QenQOvnZeToDnu
         E2WACHNzrXAKnc/vt4djCll6FtJaT1LT4MvzeGJKP7rz9ShwERR1KOQrxFD04JEaHcmQ
         mz+qNOLJE9gWYfbMCNimljGOSF89Bs9EnODbB0hrMD0sFqBXBKdP672mxqxLiCAM/Y3o
         zt4VsOHFfqc1yr9wjJPbzqHRXd3xdBzEv/iQJC4DGp0Tw31IGkbnGIkld3XJrHYoX1ei
         objdSJTRenkcH/Q/IYYeAIpshTxn+zaeZwpcoFCM+mWnmIGGO9cSOziMQOXsXhK30yfn
         tQjw==
X-Gm-Message-State: AOJu0YyJ8O0o3X6ItczToZukVxEeNMWpQPXjwZ3mflGWy7c/qY2ziaeF
	dC3MTaTH0doY0qak2Lx0fPFWQQHMZKROUTpvuE4=
X-Google-Smtp-Source: AGHT+IFwcI6k7HCwpfTSW1Zlk2+OXJ6q6RObXB0azm8g3Cr9hf873c8Snk6QmOJINgZhgweSk5h1EA==
X-Received: by 2002:a37:c40b:0:b0:77f:5e39:c9fe with SMTP id d11-20020a37c40b000000b0077f5e39c9femr160949qki.92.1702073841990;
        Fri, 08 Dec 2023 14:17:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id de13-20020a05620a370d00b0077d897deb89sm987338qkb.127.2023.12.08.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:17:21 -0800 (PST)
Date: Fri, 8 Dec 2023 17:17:21 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 06/11] reftable/stack: reuse buffers when reloading
 stack
Message-ID: <ZXOV8TCqaH0xXRnS@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <f797feff8dec383f1db9ae403cd89b80d1743432.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f797feff8dec383f1db9ae403cd89b80d1743432.1702047081.git.ps@pks.im>

On Fri, Dec 08, 2023 at 03:53:18PM +0100, Patrick Steinhardt wrote:
> In `reftable_stack_reload_once()` we iterate over all the tables added
> to the stack in order to figure out whether any of the tables needs to
> be reloaded. We use a set of buffers in this context to compute the
> paths of these tables, but discard those buffers on every iteration.
> This is quite wasteful given that we do not need to transfer ownership
> of the allocated buffer outside of the loop.
>
> Refactor the code to instead reuse the buffers to reduce the number of
> allocations we need to do.

> @@ -267,16 +265,13 @@ static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
>  	for (i = 0; i < cur_len; i++) {
>  		if (cur[i]) {
>  			const char *name = reader_name(cur[i]);
> -			struct strbuf filename = STRBUF_INIT;
> -			stack_filename(&filename, st, name);
> +			stack_filename(&table_path, st, name);

This initially caught me by surprise, but on closer inspection I agree
that this is OK, since stack_filename() calls strbuf_reset() before
adjusting the buffer contents.

(As a side-note, I do find the side-effect of stack_filename() to be a
little surprising, but that's not the fault of this series and not worth
changing here.)

Thanks,
Taylor
