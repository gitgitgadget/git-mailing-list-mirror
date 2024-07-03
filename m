Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4C1946D0
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042691; cv=none; b=rEzRw4xa8sAcbT8NZ83dPEyG9ke/T1aVJOAhL+Kn9upPoBlzd1EDpCkD537KdIBhmub/KYpy4qgGKHJVbbq/Pg/tS2ibw8ELmqO87H8eLzi+rFka1obIHVbA+0pN0AP9nolui7C12PJqQ0DXA4GaOVa0l/72Mj669aptM4gCAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042691; c=relaxed/simple;
	bh=jv2GMrNRR9fSd+3kZoN/B8xFXERttiofDwCB5hvB28o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=AVG9c5iXjZ+h2/Cx4vBr0IJH1xAy7Ke41y75lWG/JeoCU7ANMZumQ/MDK7DhvKFOjJxKyGB/gavlaCz3brJ5UeDL7qe0Fa1liWSB8BhSHPpQGSawnyfWUuxSzU7+JFoghtt/lXRtjSFUZ0P4Ofsoj8nh3EbBkD3A32Q3dKDVNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WDsfC5SJXz5w2f
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 23:01:55 +0200 (CEST)
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4WDsf37231zRnmQ;
	Wed,  3 Jul 2024 23:01:47 +0200 (CEST)
Message-ID: <772a1bd2-dd21-459a-8b95-7605fd7f52dc@kdbg.org>
Date: Wed, 3 Jul 2024 23:01:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in
 the wrong place) (just like gnu diff/patch)
To: Emanuel Czirai <correabuscar+gitML@gmail.com>
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.07.24 um 17:24 schrieb Emanuel Czirai:
> With the aforementioned `diffy` patch, the generated diff would actually be
> with a context of 4, to make it unambiguous, so it would've been this:
> ```diff
> --- original
> +++ modified
> @@ -1186,8 +1186,12 @@
>                      self.gctx.shell().warn(msg)?
>                  }
>              }
>          }
> +        if seen_any_warnings {
> +            //use anyhow::bail;
> +            bail!("reasons");
> +        }
>          Ok(())
>      }
> 
>      pub fn emit_lints(&self, pkg: &Package, path: &Path) ->
> CargoResult<()> {
> ```
> this hunk is now unambiguous because it cannot be applied in more than 1
> place in the original file,

This assertion is wrong, assuming that the patch is to be applied to a
modified version of 'original'. There is nothing that can be done at the
time when a patch is generated to make it unambiguous, not even if the
entire file becomes context. The reason is that the modified 'original'
could now have the part duplicated that is the context in the patch, and
it would be possible to apply the patch any one of the duplicates. Which
one?

-- Hannes

