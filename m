Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6169389
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crinan.ddns.net header.i=@crinan.ddns.net header.b="J+zkSHDb"
Received: from crinan.ddns.net (unknown [90.242.223.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46DBB6
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crinan.ddns.net;
	s=september; t=1698590616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqPe8MEc1ApBQ22NQxZNMYW4MZSICBNTflq4nosnb2A=;
	b=J+zkSHDb3PaiVAIINUG3/Rarqs0ykqTSnejKVz36CjMnYvk/LT6xRxI6BHR/jI3ETwUSy1
	Eg9ljTR7Q351G6LG6I+0Dz545Bc101UHWf5XljHcWkTeri5NeyiDNvSLQ/+qHZ+JffTDN6
	cbvEyEu3h1oqufKVNHS0uqeEsy5qMZt0GEfVH93fb+Jw124jpBA2foooXrr3rU6OiJaijQ
	jxNARrpU2Ktt24wjs97VMqJq/uidCA992DqNm7RBN+UOBxagj0wbXslz5G6e5P8wFaWria
	Eb+F+5AG9KZjmPwlK9zohBTGZ3sP/iiKRFgrw0gDe69nV8POs890629fPdhvlg==
Received: from [192.168.1.212] (<unknown> [192.168.1.212])
	by crinan.ddns.net (OpenSMTPD) with ESMTPSA id c9e2cdce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 29 Oct 2023 14:43:36 +0000 (UTC)
Message-ID: <9c317b54-7ed4-4ca6-ad75-6857ded0d658@crinan.ddns.net>
Date: Sun, 29 Oct 2023 14:43:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
Content-Language: en-US
To: Isoken Ibizugbe <isokenjune@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
 <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com>
 <CAJHH8bH0gp9tbDJ4DYk3jkNPD5_dZ9s62D9ae3q33aBP0ZL9Lg@mail.gmail.com>
 <CAP8UFD16OAPiRFJfjZN=soAe3WzDBteyvzv-b3CD67jz6Haqyg@mail.gmail.com>
 <CAJHH8bGK28Fc+VG3uxgC5sGgFEAw6_6AEtusgmw7c4Vz0iGF_g@mail.gmail.com>
 <CAP8UFD1+aWGymjssk5CotPjEmhu5sMcTy-b7eJc4fw-UA41Qig@mail.gmail.com>
 <CAJHH8bHCfx3vknPCGATbLZeTA7hYrVVtnYqfE1avWkiL1PvU1g@mail.gmail.com>
From: Phillip Wood <phil@crinan.ddns.net>
In-Reply-To: <CAJHH8bHCfx3vknPCGATbLZeTA7hYrVVtnYqfE1avWkiL1PvU1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

Hi Isoken

On 28/10/2023 15:07, Isoken Ibizugbe wrote:
> #include "test-lib.h"
> #include "ctype.h"
> 
> static void t_digit_type(void)
> {
>      int i;
> 
> for (i = 0; i < 256; i++)
>          {
>              if (i < '0' || i > '9')
>                  check_int(isdigit(i), ==, 0);
>              else
>                  check_int(isdigit(i), ==, 1);
>          }
> }

I think this is correct but when you are writing tests it is important 
to think about how easy they will be to debug if they fail. In this case 
because there is a single test to check all the characters it will be 
hard to tell which character caused the test to fail. If we restructure 
the code to use a separate test for each character then we will be able 
to see which characters are causing isdigit() to fail. To do that we 
need a function that prints the character that we're testing. Because we 
don't want to print raw control characters in the test name we need to 
check if the character can be printed as is or if it needs to be printed 
as an octal escape sequence. We can do that by writing a function like

static const char* char_name(int i)
{
	static char buf[5];
	if (i < ' ' || i >= 127)
		xsnprintf(buf, sizeof(buf), "\\%03o", (unsigned int)i);
	else
		xsnprintf(buf, sizeof(buf), "%c", i);

	return buf;
}

Then we can write a test function defines a separate test for each character

static void t_isdigit(void)
{
	for (int i = 0; i < 256; i++) {
		if (i < '0' || i > '9')
			TEST(check(!isdigit(i)), "'%s' is not a digit",
			     char_name(i));
		else
			TEST(check(isdigit(i)), "'%s' is a digit",
			     char_name(i));
	}
}

Note that as isdigit() returns a boolean we simplify things by using 
check() rather than check_int().

Now we can easily see which character is being tested when a check fails 
as the character being tested is in the test name. You would call this 
function with

int cmd_main(int argc, const char** argv)
{
	t_isdigit();
	return test_done();
}

I think it would be helpful for you to try and build and run this test 
by checking out the unit test branch from Junio's tree[1] and adding 
this test. You could then try making the test fail to see what the 
output for a failing test looks like.

Best Wishes

Phillip

[1] You can fetch that branch with
         git fetch https://github.com/gitster/git.git 
js/doc-unit-tests-with-cmake
     and then create your branch with
         git checkout -b isdigit-unit-tests FETCH_HEAD
