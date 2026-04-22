Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4819B5B1
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817760; cv=none; b=B31BVdDE96dFYItbazWpyXzmCqY2rWGULLGtIhi93Ii16XzbQaU+WiUCELZeDpd7q3BgzotsFrEh9zjJVSuKYvp8TcoNrUk54FB0DKuRzH7zVuY9Q7IFvoDo5RO2MXpfxNA55a2lR7a8LnJBOXS8TUcM943A3lQKR/Q3kCdmITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817760; c=relaxed/simple;
	bh=4uk8hJhA7TlK3YlDPLyZ62GctPJc4HYIxYXdJ2v6aik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJYbASt7PeGbPF6ktzgLU122BOyP/EVHrzLvIcnoRU9YnHTlypnI18Hb8jq4dhWBlAzWzUU+ag74LQlZM43ghpqlUN+IUl0KYR4VmzfzXeGPA4BTNtH4tAKzz1ssKf9OLEywuDIydbXjk/Ryfuc78Ml9B9Wic0WVjoQKlhDkxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=dfd6LjGm; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="dfd6LjGm"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776817750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY8VV5OFSwssrSQvY0nCYdhDJjR5jV5CWjEfNQnCX1c=;
	b=dfd6LjGmqHPl+liTdZha0pvSCNT9pM0Mh4dAb+ViZ8HrP0kV5wcrakcdjLxGBl7Ddy5PjS
	hYbEFWbswyzzqolBIUzMR8906+eD72QhJqguCT5f5an2s98dMbJeGo4wLdG5tFe3xvScIz
	Y8OaZZa7FPwXnLMxDpRVpXScEG+2hHM6p9dZ1BMJaV+fosfOWfFz87cpUi5porWmxk5BpV
	vsVHfifCMG1DpicQ5gQtvecGop/SAjafLeY9pjRLPtKX7Swq+gJEyWeVXogoLYd14p+fbT
	wBr7eXfypCLdet6HIoJLIwm5gyC7t1mkPn+nD1jQVPIXajFZfFQhbnUvKdaX3w==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v2 0/2] revision.c: implement --reverse=before for walks
Date: Wed, 22 Apr 2026 02:28:39 +0200
Message-ID: <20260422002840.303477-4-mroik@delayed.space>
In-Reply-To: <20260418164736.2367523-2-mroik@delayed.space>
References: <20260418164736.2367523-2-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=mroik@delayed.space; h=from:subject; bh=4uk8hJhA7TlK3YlDPLyZ62GctPJc4HYIxYXdJ2v6aik=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6BY4UBrfwfDdvcR/I0RUR9qYdDRCnvHvEU9tS bBNOzLAk3+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaegWOAAKCRBIeX6hnBm+ 0VybEACphYUGIzxJGRydR/k/9Nxq3fXPBvMQcB0qDfSIH67t84XJiu30TEwF7jYSit+Yu1cw+bD 1EkCf23rXi0LOHG5fkNvFYUiXtqGtxef2B2WEewt58v6lG1zCkDDU1Un9d2UEC7kK4ja7S5vRZo kUnPre5MjVULJFVWHyWyGad0un4zh9eLpcyYcYb6o82GVQnGsJu4s8mXy8suNKsmKOo36r1tLK1 /oV6tdxk3u3mCQW2JRgkObUsNHf37JqR+XFZ1v6fYNVP5G/0q+pLLBwLZz4lyNOF16RRY9Gy/L9 oK5nOmtVkYJ91UIKk4k5lNeGARGwTxeUEdl5uJSoU/IJA89tOH+MN5WgfH/BLEIRzlfHM0RGHe+ 95jE66jjV754TySEdzwH+1YtdUzxOTgTzueAT1mvm/xkZq1g/Jh3IF5mRPSaXyfa66zNgdEfoki uM24wyTIqASWKkmBacZu+sgym5BE0RYTsyic/ZU1uqN1dCmvvR/s/rVa/Ap1nN5DOWM8DPfRn+Y wkozsrb8zMrdlj5685hYQVid1P6buexX6odaQeJkYVxFvvqiCcrltuWDIWZU5TKMStNvtKrJvS+ /A4AD5l2CvMdhjuHuyEW3tHBXjy5PxEzw01RAJC83KsSwaR8dpM9jRJe8tCm44sSc40cR+laapI 9h6o8JiNSmZ6adw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

Since v1 I've:
	* removed the non stuck form for the --reverse option
	* --reverse with no argument now flips "no reverse -> reverse
	  after", "reverse after -> no reverse" and "reverse before ->
	  no reverse"
	* implemented a window to reduce memory usage when
	  --reverse=before with --max-count=<n>
	* updated the docs to highlight the peculiarities of --reverse
	  when it's specified multiple times

[1/2] revision.c: implement --reverse=before for walks (Mirko Faina)
[2/2] revision.c: reduce memory usage on reverse before (Mirko Faina)

 Documentation/rev-list-options.adoc | 14 +++--
 revision.c                          | 85 +++++++++++++++++++++++++++--
 revision.h                          |  8 ++-
 t/t4202-log.sh                      | 66 ++++++++++++++++++++++
 4 files changed, 163 insertions(+), 10 deletions(-)


base-commit: e8955061076952cc5eab0300424fc48b601fe12d
-- 
2.54.0

