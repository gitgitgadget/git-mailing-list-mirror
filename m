Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UFRSDXdJ"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4999CE6
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:15:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA4871B595C;
	Sun,  3 Dec 2023 08:15:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OY1fNG7FnK6aqGLAuCGxuzp6ozKh4FY8XWLYst
	lyinE=; b=UFRSDXdJEbSmjP7nUmqBU0sO4/LlRKgiORp4jVWjhUvH0x9dU044em
	rF15f0EhU9kWJtPRbutCDJ2iECoK9L9uuIvwUMEJ5x6PgNbGCKD99jIuPPRCRl1n
	lHDUz4M4vwTJXLI6j9+yvt2X0/lyVL/q+aILg+jXNQ5cXvSTmyxpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEFB91B595B;
	Sun,  3 Dec 2023 08:15:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD3F81B595A;
	Sun,  3 Dec 2023 08:15:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/12] treewide: remove unnecessary includes in source
 files
In-Reply-To: <dbfb108214d71ab29c29230eed3c4d40fe4b42b7.1701585682.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sun, 03 Dec 2023
	06:41:11 +0000")
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<dbfb108214d71ab29c29230eed3c4d40fe4b42b7.1701585682.git.gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 22:15:05 +0900
Message-ID: <xmqq1qc35sx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA52C15A-91DD-11EE-8B5C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/trace2.c b/trace2.c
> index 6dc74dff4c7..d4220af9ae1 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -1,12 +1,8 @@
>  #include "git-compat-util.h"
> -#include "config.h"
> -#include "json-writer.h"
> -#include "quote.h"
>  #include "repository.h"
>  #include "run-command.h"
>  #include "sigchain.h"
>  #include "thread-utils.h"
> -#include "version.h"
>  #include "trace.h"
>  #include "trace2.h"
>  #include "trace2/tr2_cfg.h"

An in-flight topic seem to want to see git_env_bool() that is
declared in parse.h that is pulled in via inclusion of config.h
hence this hunk breaks 'seen'.

> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> index d5ca0046c89..a0032ee3964 100644
> --- a/t/helper/test-trace2.c
> +++ b/t/helper/test-trace2.c
> @@ -2,7 +2,6 @@
>  #include "strvec.h"
>  #include "run-command.h"
>  #include "exec-cmd.h"
> -#include "config.h"
>  #include "repository.h"
>  #include "trace2.h"

An in-flight topic starts using "struct key_value_info" that is
available via the inclusion of "config.h", hence this hunk breaks
the build of 'seen'.

> diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
> index cac20a72b3f..f9472c99143 100644
> --- a/t/helper/test-fast-rebase.c
> +++ b/t/helper/test-fast-rebase.c
> @@ -24,7 +24,6 @@
>  #include "read-cache-ll.h"
>  #include "refs.h"
>  #include "revision.h"
> -#include "sequencer.h"
>  #include "setup.h"
>  #include "strvec.h"
>  #include "tree.h"

I'll register the following evil merge as the merge-fix/ for this
topic.

In addition, t/helper/test-fast-rebase.c that is touched by this
step will simply disappear with the cc/git-replay topic, so it may
not be a bad idea to exclude it from the patchset.

Thanks.

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 16089f04e1..55c06e4269 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -1,4 +1,5 @@
 #include "test-tool.h"
+#include "config-parse.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "exec-cmd.h"
diff --git a/trace2.c b/trace2.c
index 4fa059199c..452428b09b 100644
--- a/trace2.c
+++ b/trace2.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "parse.h"
 #include "repository.h"
 #include "run-command.h"
 #include "sigchain.h"
