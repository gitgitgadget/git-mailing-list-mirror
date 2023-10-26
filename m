Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4215AD3
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF86C10E
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:07:10 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 2B84D23F67;
	Thu, 26 Oct 2023 05:07:08 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvwKa-Iq1-00; Thu, 26 Oct 2023 11:07:08 +0200
Date: Thu, 26 Oct 2023 11:07:08 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <ZTosPCkpx/FMTDH5@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>

On Thu, Oct 26, 2023 at 10:00:20AM +0200, Patrick Steinhardt wrote:
>project has. More esoteric jobs like "linux-TEST-vars" that also sets a
								     ^ 
								     -s

>couple of environment variables do not exist in GitLab's custom CI
>setup, and maintaining them to keep up with what Git does feels like
>wasted time. The result is that we regularly send patch series upstream
>that would otherwise fail to compile or pass tests in GitHub Workflows.
       ^^^^^^^^^^^^^^^
       that inverts the meaning

>[...]
>project to help us ensure to send better patch series upstream and thus
			   ^^
			   "we"
>reduce overhead for the maintainer.

>--- a/ci/install-docker-dependencies.sh
>+++ b/ci/install-docker-dependencies.sh
>@@ -16,9 +19,13 @@ linux32)
> 	'
> 	;;
> linux-musl)
>-	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
>+	apk add --update git shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
> 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
> 	;;
>+linux-*)
>
you should probably choose a less generic name for the jobs, at least 
debian-*.

>diff --git a/ci/lib.sh b/ci/lib.sh
>index 33005854520..102e9d04a1f 100755
>--- a/ci/lib.sh
>+++ b/ci/lib.sh
>@@ -15,6 +15,42 @@ then
> 		echo '::endgroup::' >&2
> 	}
> 
>+	group () {
>[...]
>+	}
>
this counter-intutive patch structure reveals that the function is 
duplicated between github and gitlab. you may want to factor it out and 
alias it. or change the structure entirely (circling back to patch 1/5).

>+	CI_BRANCH="$CI_COMMIT_REF_NAME"
>+	CI_COMMIT="$CI_COMMIT_SHA"
>
assignments need no quoting to prevent word splitting.
repeats below.

>+	case "$CI_JOB_IMAGE" in
>
... as does the selector in case statements.

>--- a/ci/print-test-failures.sh
>+++ b/ci/print-test-failures.sh
>@@ -51,6 +51,12 @@ do
> 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
> 			continue
> 			;;
>+		gitlab-ci)
>+			mkdir -p failed-test-artifacts
>+			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
>+			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
>
you're just following the precedent, but imo it's more legible to quote 
the entire string, not just the variable expansion. the code doesn't 
even agree with itself, as the line directly above apparently agrees 
with me.

regards
