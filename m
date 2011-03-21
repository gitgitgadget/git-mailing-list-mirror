From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 14:58:25 -0700
Message-ID: <7vd3lknnjy.fsf@alter.siamese.dyndns.org>
References: <7voc54sb41.fsf@alter.siamese.dyndns.org>
 <1300730506-6582-1-git-send-email-bebarino@gmail.com>
 <7vzkoop912.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:58:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1n7a-0006yq-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 22:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab1CUV6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 17:58:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab1CUV6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 17:58:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F088540A;
	Mon, 21 Mar 2011 18:00:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z4yoXvZNuPTDnE5bAsErHSna8Bg=; b=cwCn2y
	cau0BdBQHQnI/4Fw8GaKjU68Tr+PqlipElbJ2BXaxcs/FZk0XyBF3cvdUJFTtkgT
	eQD6xQB85tC390WdctKUrpxHq2zOD3Km5hUfKzvt51JPYwzobTvyANy84Y4jDl2t
	vG1XlWGV1HJTnFLLS/zj235ocxovGQSzCCiXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWEz1NDEpDop1IYG/1RwEXSXi0BknVIy
	5OBLabfrMboD2ftKEXBXiQROlxC4mFt9hnrjENSJsXjXPDK08HeqlQbR5Y5+o/jn
	rmBzFenoXq3RJftsP11EnhhAvVNj53vIDRKlGi9Enz58vx7O/O55AdqCxiFONgpk
	JiDRcM3Hk8M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0AEE85409;
	Mon, 21 Mar 2011 18:00:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78AAC5405; Mon, 21 Mar 2011
 18:00:06 -0400 (EDT)
In-Reply-To: <7vzkoop912.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Mar 2011 12:29:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 981BC856-5406-11E0-AAC7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169676>

Junio C Hamano <gitster@pobox.com> writes:

> Still yeek...
>
> What I meant was more like at the minimum:
> ...
> or much more preferably:
>
>  - These files use symbols without declaring, because they do not include
>    "builtin.h":
>
>     builtin/clone.c (cmd_clone), builtin/fetch-pack.c (cmd_fetch_pack), ...
>
>  - These files define extern symbols without declaring, and they can be
>    file scope static:
>
>     builtin/fmt-merge-msg.c (init_src_data), ...
>
>  - These callsites pass literal integer 0 where they mean to pass a NULL
>    pointer:
>
>    builtin/notes.c (resolve_ref), ...
>
> The patch text itself look more or less Ok, but I see you have builtin.h
> not as the first include in builtin/pack-redundant.c.
>
> Thanks.

I spotted these two.  thread-utils.h already includes pthread.h, and
builtin.h should come before (though technically exec_cmd.h does not
depend on any external types, so this is just a conformity issue, not
correctness one).

Again, thanks.

 builtin/pack-redundant.c |    2 +-
 thread-utils.c           |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 760b377..a15e366 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -6,8 +6,8 @@
 *
 */
 
-#include "exec_cmd.h"
 #include "builtin.h"
+#include "exec_cmd.h"
 
 #define BLKSIZE 512
 
diff --git a/thread-utils.c b/thread-utils.c
index 2c8c1e3..7f4b76a 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include <pthread.h>
 #include "thread-utils.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
