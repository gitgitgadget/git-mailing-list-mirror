Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5812B94
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918416; cv=none; b=YWXPiGgBGkhHwM5oCvyNQL/gO+KG4HyWKxNreWUdYPszRkwpkuK4SzRVlVmbW/vA/srNmKRLExdcmFs66F3ajr0UbwyPsViQNMPHThNoyF39qFv4/62pCrZ3hmnsG/rw+lskw14riSs5YHh98zonE00n7pyyY4haEKSeQYVZ7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918416; c=relaxed/simple;
	bh=uGYVCXjv1CYPOfzXA9aF9gDDWfqUnThKQGmhJ6c2Q/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VS3mE8CV1H+GaTfAaIkZe2fJuIFHDPSI0Yrkua74SxJlRI+cUG2o2yjbWOifCmat7myq69z+WLRq00DG1LrJM7DvrctOn3zqVQnVp8W7DDc6isMD3xn45Bl9JT3X/7iACM/WXN2MdIAElr6bvEgk/tZxL1cjAnXtTcGk//0tBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=tlINW0gD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="tlINW0gD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773918410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G49OareaYCt2teInA0RE279PjTo0P+3mF7bk1YjPokE=;
	b=tlINW0gDQ1XXebTXk8GrAnJa2syjbW4Toue7vxgJHRwFRs3wx255Hm+K5wXX/plcGZngAA
	6b6HL1QHQI4Uqg0BF77ubvkMmrLuj7n2qWKNe/jXGz8MEbfegWG4oSBZtQGo+2nuPdkWo+
	d7gZLWZ4YGem1vd/VlZ9stEYJOrJdPI=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Matthew John Cheetham
 <mjcheetham@outlook.com>, Victoria Dye <vdye@github.com>, Derrick Stolee
 <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git-compat-util: make git_find_last_dir_sep return a
 const pointer
In-Reply-To: <20260204053218.GA942606@coredump.intra.peff.net>
References: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
 <20260203062537.GA286409@coredump.intra.peff.net>
 <87ecn18aip.fsf@gmail.com>
 <20260204053218.GA942606@coredump.intra.peff.net>
Date: Thu, 19 Mar 2026 12:06:43 +0100
Message-ID: <87a4w42i4c.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

>> > Looking at strchr()'s declaration in string.h, which is defined like:
>> >
>> >   #  define strchr(S, C)                                          \
>> >     __glibc_const_generic (S, const char *, strchr (S, C))
>> >
>> > I think the answer is probably "yes". But it also doesn't quite solve
>> > our problem. That would give us type-checking of callers of our
>> > function, but we still have to convince the compiler not to complain
>> > about its implementation. For that we'd need to either cast away const
>> > manually, I guess.
>>=20
>> That macro depends on Generic selections from C11 [1]. I wasn't sure if
>> Git would like that, given it is conservative with other C features.
>
> We definitely can't rely on it everywhere. But if there is a solution
> that is conditionally compiled, and can kick in only when these extra
> warnings also kick in, that would be OK. Assuming the result is not too
> painful to look at, of course.

So the Git project would be okay to conditionally compile with Generic
selections if the compiler supports it? Seems to me this is the easiest
way forward to silence the errors for users who see these warnings (that
includes me).

> Probably the best path forward for most spots is just fixing the code to
> make it more obvious about its use of const.

Yeah, that's in any case a good idea. I think using Generic selections
should make it easier to locate those.

This is what I've done in an experiment in git-compat-util.h:

    #ifndef find_last_dir_sep
    static inline char *git_find_last_dir_sep_nonconst(char *path)
    {
    	return strrchr(path, '/');
    }
    static inline const char *git_find_last_dir_sep_const(const char *path)
    {
    	return strrchr(path, '/');
    }
    #if __STDC_VERSION__ >=3D 201112L || (defined(__GNUC__) && __GNUC__ >=
=3D 5)
    #define find_last_dir_sep(path) \
    	_Generic((path), \
    		const char *: git_find_last_dir_sep_const((const char *)(path)), \
    		default:      git_find_last_dir_sep_nonconst((char *)(path)))
    #else
    #define find_last_dir_sep(path) git_find_last_dir_sep_nonconst((char *)=
(path))
    #endif
    #endif

This leads to 28 places where the warning happens:

    bloom.c:515:52: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/config.c:855:22: warning: assignment discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/receive-pack.c:1045:19: warning: assignment discards =E2=80=98c=
onst=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/receive-pack.c:1075:27: warning: assignment discards =E2=80=98c=
onst=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/receive-pack.c:1098:19: warning: assignment discards =E2=80=98c=
onst=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/rev-parse.c:278:22: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/rev-parse.c:339:21: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/rev-parse.c:343:28: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    builtin/rev-parse.c:347:28: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    convert.c:1189:24: warning: assignment discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [-Wdiscarded-qualifiers]
    convert.c:1212:32: warning: assignment discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [-Wdiscarded-qualifiers]
    convert.c:1223:29: warning: assignment discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [-Wdiscarded-qualifiers]
    dir.c:3526:15: warning: assignment discards =E2=80=98const=E2=80=99 qua=
lifier from pointer target type [-Wdiscarded-qualifiers]
    http-push.c:1775:44: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    http.c:755:43: warning: initialization discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [-Wdiscarded-qualifiers]
    pager.c:121:28: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    pseudo-merge.c:647:16: warning: return discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [-Wdiscarded-qualifiers]
    range-diff.c:109:50: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    refs/files-backend.c:2199:25: warning: assignment discards =E2=80=98con=
st=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    revision.c:2135:24: warning: initialization discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    revision.c:2179:14: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    revision.c:2188:14: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    revision.c:2194:14: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    run-command.c:608:32: warning: initialization discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    send-pack.c:184:19: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    send-pack.c:215:27: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    send-pack.c:240:19: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    transport-helper.c:803:19: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]

I did not look into any of them, but I think you (Collin) have sent out
patches for various of these? But they _should_ managable to address?

--=20
Cheers,
Toon
