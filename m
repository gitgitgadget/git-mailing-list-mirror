Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1225B09C
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484061; cv=none; b=SmkRKOAHVpAJJbZI/WlCj/063+I0dAo7HsqJFexvKkcOMIUEa/YOkiJu3fXi/T7Kt0EWRyri6CaJSM2DYXrcsqbTlOgo6Z2sf+KsG3p5XYRq7X+PV8hMeUCa8QBmbbOZIrjvxcJmGiJgyDsQpDLCFhlSPfmgbtkgvh8wjMxnH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484061; c=relaxed/simple;
	bh=R02wptAO6ohI7PGBxF4D8+dMzsWJPj7RlC4UwJemn4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1IQHIh70GNU4QSQ4z/o6vmTNSuJuR9gA/7hQ7kpn2ZoQtP0L+Dsm0OJiaRzs2ojPDknQrYBHKrrYUgO+9w1pS5T7S+17BZl4BcjtQVAjk9CsslRuhdaABd1kII/XagRQuBM23YaFCCboeLu4gJB4DwtkkbUkphxj9bh5pfjdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AeMd1096; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AeMd1096"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786484048; x=1787088848; i=l.s.r@web.de;
	bh=fHGx/0x8wRDgu8wBHLt1Wbwsn9eCuI3oJZykn/fYiXU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AeMd1096QNlUoNgA1JznyPdJ/x4h3QA99T3s0waBKqpanHmOxTBxo9gdODVzAOD0
	 73PV3AAS9aTYyiGU9pjcZkY5eSF+TlYxLAczea5V/mkWtjSC8JrHB8Bi83cLLeubR
	 DJ1UTw1gMVQjmA7WYcLnYQ7RldPI/HRkhDr+AaV59bARNzYsGU4gV9sBAmrRB1+fC
	 zRPhks7Y+JletqdUWBrONakbbZ0nQRolL1J1fVShh2fkXQmv1GuqgJNQWO8r4keKU
	 UQP6QDuf/NDTOl3yzSk2qtWY1FQkoJXS8ldpKliCs5moBY3DwQNDOrhbOk/4lL+b6
	 IGHE8VQlbJP6bVCOuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc7b-1whXeU3xp7-00Bc8u; Tue, 11
 Aug 2026 23:34:08 +0200
Message-ID: <52ee6501-24ac-402b-b650-92a829030380@web.de>
Date: Tue, 11 Aug 2026 23:34:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v1.5] worktree: Fix out of bounds read that causes data loss
 and reject invalid empty input in worktree add
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Marc Branchaud <marcnarc@xiplink.com>,
 =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>, Junio C Hamano <gitster@pobox.com>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5BYuV9P6Wkds6Xio/KoS5MG4euo7T53mrxNTKYxPbPCxMn+U07n
 eGE9cS770npyTrTu2D3fwEO6crZWgSAwq8a7cxoZe0/LHWVPAyfW6+HeA9PSzs/9wj3o1Hr
 9HAfyU7bbbZTzPb3Mn5MacpujE/voimF2XLI7cODq3rPLVy8ud1P2WnJTtoZO8zTb3jccH/
 /S3cgYwYEYmjfXHeMrg8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bIggi17bxJk=;vWAw6iadw8B+n+VWCbY7EpdeTFJ
 aWf1dHAa8CiaI3CqsSc5skMxmzYC8LynhbUfLS/VqORuqFSIleOM0iwpoOfF6RlJF7ZBBIAnl
 CgfCg3Muj2rj8FPwLHoztbNrLID8RT8cr/qHiGmSHCYH96k5q3JSkIEKkbhx2wPr42jLpoqxE
 VGEZ0oekA48Y6WTIbi5XJgWUeckx0jg90e4ALPQLX0qA6QDiFlccgIwCH+xhbQQEUKFUPmfst
 tLnKnDKwOD+KR8NtJ6OUrfex5CXTPDJOjz5A3AGxDoHl1KGnSLZkykcqaDeQe+mFlmc968LyF
 TkXTgK3C50QZ2H4+kK4GHQUd1WpG8jWu/gW9Y1crZwjvqwORciThTN0laHzKsOOzNQloAWsaB
 8qItcSaVmtVyjO0TbbQWGzyDT7yMpdbNYdKB01jcopeGsHVYNALkCXXzak4cJwj9S4+G1pqwy
 FmH7rsUFk4lLubCC3NbUUUNDxWlnN0jXlC4vZgpMRDr8FdoqFaK4Gwgn+zCftAxB9EcIa0RvI
 egzVIiRcX/lfAMOs004CLglBzvhoPkkmK7funQpUQJvAKz91yytdgYy5DHP9gRe8owNyhx6QI
 4qgcsB/V7IJ8wSodJA5HDQVFhzOG3TPIexlofss9vpP+geEr4puoMwKdpsN3WIbarfpLWxZST
 QG6OfAjZGpEDSnRPm9r6vQ4VJQownbUB+Rv7dBtIbUFMZi+6K47VSnkEf5qTtxaM7euq2mnMt
 tA/B78Hrbiu9zMzbMdK45zhOexJSmUnxfsisCp2fRz7QiEpO1FMkqgmTwnTLejpzVXW4YFjSZ
 m6MlIVYnqIXqO/E347R2DfsI++yYn/Ke1A7bwuHFTo2kwBCEJMx5Lho2haIngrSQ6aw7eOJ+j
 r8N0rymEMhasVTlVB69Gr7K4HyqsFNNUJ7tANhNKB5jMIjJi/VmC6ISOveI7RF9Fx0wBoHQJT
 JRkEGduncQqflskt+NkI+phLJ4Dx8UVsEYaBhDdYbUBjdE05w7L2qiui+6iEpQ/qRVcEdwEtd
 hDi2s4qMK2pzaIh2upDT6PKAsPg3yUhPf8LiLqXmcIyOeXlBQTxPFeX6g0YXsTLTsH7F57Gdz
 STqCylrqkXPFNqs7/Aaxf7nUKKLowXscLwaGW5RrL+Bz98XkiC1lfcYCNog8h0t56YeRqtkv1
 jj2OuN+UP2IJNGigfD3HBkO/iEeTNLCGE+IQeYEwD5niRGlsZtEU8mP18aChl0C++eOVSGy2k
 Mp1FlOTdol5kDpPeQo3WUK43m82R1mlVcMEeR+68jeI9DfRX0Gm5y1PHJHmlE57xCBUR8rs8w
 ggCrsC7a0foVjFtencMYIeGYirqM9+wHq7HmDXzxzJe908SoE4PdB6Kuy74PQL/vsw3Ksttc+
 GpDaTc0mqG+AtulgBzLekiZuoGgf+nPz0+1eHeCML3NBrtXLsWlkB6Q80H1XLSvx6sUiYMzmz
 cDg32OmxZ9kETGpeRzerOz3/ki3p5lxzJ2gpVlPsqorck37WwQ99+CKf5Be0VVXUtLeuh81ZF
 zPlQmWkK/p6G8xfurlukCb38sJWWD7Cl6vWgROU3msWDxqURlOCVbRSzFuiAxGE6QFIZEsWAG
 darVaLMdQYc7Q5o+x8AGoJJ4fO5qVBiX1IdQ29KqbW2+NfB7SdK8pFOGIDRc0kVUu1J8tvkM9
 TH45Glif4p7+Jjl7gfiOD1wrtH/iR+oH+7kgiyNHYCM0BWblkv6c5seXdWr+6IaD9P6eG+YBh
 otE5AYFvwghpHx/jag4l0gQr8iraQTqOknGogQqhc7TpFhYtQ5W+000tG1vukipYbsShzMMsn
 eG1cLL+YAy2eZHISK/0RLS9I/fmES2V1TiVp5SCM5R64JzItqJvd9drwSIuCK7gFluHNdQAFA
 xupup1RNPTSOA0vNHqoTqyihzEwWLI/4tCj5SGo5jiKUDxxKThdnCeLFucpeKVSc5dXVGEUfX
 n2qk1ddUGa/v58Rbd39yzLb3tl93SxLPbDS/RWSjF36GX2K8waM92ScexMtAfQ+dnoVfw8Cg2
 NKYUZYDiElBazjpFvT3tQgkhhCTl+BAyAhxF89vn8VoLiRgn+TwlF4Kj76TkbvxxAdAVfhvtA
 dOtewBQYqf+d8drduMgIWVSOL4uLfdEyHErT9ZHjIyfRUqtcsmJfed1SXtyY3T9UtxuSPXaTI
 /KzLRchnTWFAEGbYh5abgUQ/pI4+xtatW7t8yJ43BF9AoVH2sjuJorMTtQw+Io86cCxjP9eIr
 3Bj3TUTFFxpOryIHatd1/w+nsd/2pwCFeUp+om621rqpzw7HO9brqqq/82akdTocU3BI4Ddin
 GdkiPnH8oBc+aUfQS0n0oAAyeXfNr1D4ECkz2x+6NYbl568Vl1/ptUqkN0R99/PraUmjvqqAF
 sUKQjIsxMCL7VX64ovvN3ZlI/Oa1xyEFjKju5AgdCRbutAuFTI2Hhosw1sos34rywPa7LidOT
 RLnTX9BhnftPH38mIbeeErXtRW3Fv7NJQJh6GQTc6JGNoqKHeNabZLU+c1eLnp20lJE5zCX+T
 BWSvSkWXt2x7VyE1OyvTmAE8WFZu9u9gWpnEx8iuuBQudWZytzDuwmNZcaEvekerzghmI13a3
 kmQNM3Wfv6/tCKULplEUvI5s6DZNZo9VyVPkcgKyVuh4wSBF6WKUW7SoTjymTwNjFYnHKw5TT
 W5HI04qkQsw4ZmtGuDoersC7qlMYi2kMoYYka9h/OCMY3eqn2TqwKD5BqlLC979qXvSZDDvyV
 DQGshWTjgKa8msavzUQmbl/H4Uq5tJXQ3sQxtmNsCAe3NDLXgbIpja1c9n44A2xQRuG4IZS6N
 rtvkfEHCHSX0tUy68lBNR61YHZfc8iCS1B/RYZTTbxDng3hSHmxGsPB6ilItA6z1XvlNCrmlC
 8HFD5y0oSvnRQb5LlY8Ceau57wZJ3WF7dejVGFP30aMyZ8j+jQPMs+zZN20cw26p8C5R7e1c5
 AjfkEEEwWTsG86Q5+pH2jY7Word1Mflu0M8BxhYLb8f5MqLA2VYMMMht8SgDKBfrcHIFygiEH
 2YjK+13ysQ2JdJBdHHs86aNZuWfO/0COciasC35QlqZiepMyPYFqVAM6o/pWPms9k0q+jK81Q
 wyRFylrryR9/KV+WL3mZ1dY27ywyZN20/X72ls4JbNH9lYznMC1TFqWfyEB41hJ//1Aj1IZ1o
 SPcK/NkX8JtOqb8uvwpa+3O2VyhBmFFF1l3WP4aCrjGQQWnHcGcIWo4k8JkU22vyRdJiZGHgB
 kkM/Dhrvj5mcofz1QDiDvoPReik1vVGvEG3ic38OYz4J5Y4vT5vL7eXZ9toDKrygdlNsRQ0qb
 ucLUC9RgqdgHm1dG5UHMSLIpyjcEjmg7dX9Xp/7cCmqjD/LJJ2EoIdWTrwEFkaJIHZkPokRlZ
 2sfoOYto5EvKLLb/C+Uckb3GYU5Tw1QVSBxFKnTAWP3ASrzVy4cQCIeJZ3ksEpcz4GxVq0TXF
 qJ6o7cMGKd6/HVyU5p1RxnZ86i3I7qEXDk5fYC7lasV0IN0NKD9aUnGHO3TWZ1wn77EsY1WNX
 GHzD8Aehf/hL66aFnrF7rS+jjfKfGwbCuw2whNB5QXigCLRyVB9lXXYm/JHxLgZaf4BhKd8rn
 kwbDL+3h9xzsdcKrGnT/+RpfN3qQG5UpDH6FOJgO89R1ziGuw9+IQu6QSm+1nymch66osSvmU
 bVsFd3P0+pWMUuluq7hOpL/Lry+ZbWPfPguVyLhRa4A0BywxFZwEgHNw6gKKcq+j/RZm6D6wZ
 HS8VZX6THyuLdjH0RmknFmjz49oq6pRijToC0taXm1/u7Y7LqWkR8NZEDlyjbaFQOeLas8IrT
 PoONBgjlLwvz5ml8jkgWHOxYcYDZL2V4FM6h3GbVILHJzJxc46UBRcCCo4lkRoNRWLw01LzwV
 4o+LW6q6UkNpbJrJKDDsNN1hLDp7CfpaVPEtisqNyvgQT5Dl6flOBSxq3nXtUKhkX5LI8M8hi
 Mma/Uanou4okbZuIJtYXJ1p4tos2MPfnnhmI7i/Yc4HwOvonJ9Xt8vydmabGI+5wjL+6XV7tr
 vYWEJsUSHVwtybXZ0ZEue2qlvJtHtbT555WnpVbTdSwXDsJLjLjcXzASydeDCrQ/gsQf5MGes
 rT43ZphEL4HD6Wa2/3kKcCPPCBbXgidqZZklfLZ2sQoq+v3x1qILPXJm8fMRSphyuIIE1+Gcs
 DZFlqegQ8Fs5aOnEYt18xKsUpguA59pxrgY2+rTuNwIuMjGCeIFBbwflzxMZzrrC3D5EQVmIZ
 MVqKQi567phFCzxLFsvNB16PQYEhjvrsI10DxHU4vKYj2F1obiFAjVCSbQdYqBFKP8V9AhBWf
 Tz00Du3F0qHx4MiIBS+vDsw0KjfwsGSKHixypBVo/W1q456yMLK0E9MZeODPpfdM0RDqj4dqC
 6nPnIoq/xTpYdO66S7gRvOP9Dit6a/hKVPiEOmWarVxlbX8z5vIqLgWLyd8+hF6vD6XXESQuc
 BQjYNLCwhbU3pViCA/lO5mj9aHIHylccPU/8Bh86Gv9ohZFddYtcriX20b+dDRuLF2TkaGnrm
 Lw8IZ1TtJj9B03XHqewYrM9qAduRLhSiGVoOHc7aly7C4pL0AbDNCL5B+xUPTvPee1MbCrAOS
 fQFKSlPggjkOvATjvm4BuorYYKtkxnsjOJmBN8gOVP15XO60F3sP4pYjMuccjw+r5DSKcpnOi
 EKGaJ7vfYkkhrvM1sccxJ+praRrBBzyXv23xSE8S8lNivP2qTgZzDFkUEgfl4UUD1CRqeOene
 UU6/DH0tifkNS6I3rhGYW+CCVS/95Aqds3z4ZIQzxCh16WxscBenm7Ez7GZVRM4x+Q2obc+Ly
 9GbJPjCjMHAcSHfAC3bLMut58WHfHvC2KIRj2m7CL7iqY54Z9M0c+T5U/wLWbhi8A1Pd09i71
 LDrX7B+P+nGZg7gKiNwm+sDIaq+HgO3EUKwaPkgSAblakm60f57VCJsGJDo1LbsyvHI2MEUyC
 3+K25KVSI7s1EL0szbI4wXZIjvxLO7lwbt80DbPleQSNetfaCrOpaUNjLtiG0KH2J3nXN2UxM
 xjya2i2ErfV1XNT8dkAlSjh/yhNnz4NNCny6OzjrC5pXMb/CDmonEoeOFNS6+Qnc/eKk4jYMY
 rsFU1ietAr0yyXDi+ABeTZMlrhIXCNVHxvtEcLrW97wUoexDcGaTvW7wTO9urQpzpLzn0w9Yx
 X1H8mme62E1+NzZK0ZeUxw/lhw9JoZgcVVnO1cxQorvA/xLe4t/33+uhma6AWGG3Whn8J+mpo
 3fcSazc7phXTtX169Pm9GxazQVVr2xnRShXzD/R0A2Wk0vOlHl6O2CCZLr2VoiHWuE+NGC+Y5
 oNgrlTIYXwKZlXhLjsoGdvWFSulVG9+o916hkH7xNxol7bG39WaDW4geDsvaR8JtPg9ERoWU6
 GJIgUKQ+CV6xS7B6E6/bpM+PaOEk0jyog6ch7JsoMlKp3uWcWZGugm0LxYQ8YNbSJY9o+wibg
 xIe+BCJ36umPjDSLDuVvyClZfBGsrBKuETnzIjvLdn6mvTxWCJbEn5MMr46WJKerhlwt9egyG
 Jh9dmvKT6pk9sMC5TdVlpboFkOpWe2PhGOa6F5m+V2f1slZpCy0qIDQtfLnLMs88/IPOfiYN1
 aNxOTZRCWpde49gAyGzmDVK0xax6KwK2JlyNXxNagx5z6TWpfQTtJbpRvTkzrbgrChCh6SbnQ
 K+7cupEV4Ap7dz/x9uifo/ENVrgsWNt6LNSHrjkNWYgTKpUvMf2Gd9LI+GcRf0KazuZe6yW9m
 fh7k3ldRTI7g01gRmUJzkH6SHOVpkUctg3jkEaWs7o44bgg3OgZPbJHpNs9kvSO7Z4Kg7XecF
 dhSdhj2ywoNea8aDd+tST9x60xc6p9JYq3sAcz4v4WcqZLCHYz3wAHGBNXT7iiHFpt1TRFa6F
 /jCWTmdqaM/IKiRMgqiluhfZcoNIcNx7rEAOK/KpoQXCFP2Mzpi8Np5UZMtxFEYxsl7MXdN5W
 IX1eLP0hB37/Uppg0rKj/FH82Q+0FDzJB77WyttU9+QikmOAihgzdTPmT287wh+Ik+hNw103B
 I14Af+hSVPt8q4gsAVm4CKm4cX/tVOwhq0eoif+p+q8xwDVa2RRTXgjtm+LGSrv8JqYA90A==

From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>

`worktree_basename` tries to read from memory before the passed `path`
string, if `path` is empty (or only consists of directory separators).
That results in unexpected nonsense data being returned to the caller,
which can lead to issues, such as `git worktree add ""` recursively
deleting the current working directory, including `.git`.

Stop reading out of bounds in these cases to avoid that behaviour.

This leads to `git worktree add ""` consistently exiting with the
message `BUG: How come '' becomes empty after sanitization?`, which is
still undesirable, but at least it doesn't result in data loss anymore.

This fixes https://github.com/git-for-windows/git/issues/6346

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
How about this while we're waiting for a reroll?  It implements what the
commit message says, nothing more.  Follows the style of the first loop.

 builtin/worktree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..a770dd5ead 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -303,11 +303,9 @@ static const char *worktree_basename(const char *path=
, int *olen)
 	while (len && is_dir_sep(path[len - 1]))
 		len--;
=20
-	for (name =3D path + len - 1; name > path; name--)
-		if (is_dir_sep(*name)) {
-			name++;
-			break;
-		}
+	name =3D path + len;
+	while (name > path && !is_dir_sep(name[-1]))
+		name--;
=20
 	*olen =3D len;
 	return name;
=2D-=20
2.55.0
