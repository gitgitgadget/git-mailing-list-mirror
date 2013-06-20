From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 14:41:53 -0700
Message-ID: <7vbo70qx26.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
	<7v38sdzx8o.fsf@alter.siamese.dyndns.org>
	<7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 20 23:42:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpmcD-0000VO-Jc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253Ab3FTVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:41:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030221Ab3FTVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:41:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BBD296E5;
	Thu, 20 Jun 2013 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ln/94AGXpYmd5SEcj4EB6yQCaCk=; b=XgMD42
	nKBGh1RbT2cZxFWVMjCqbxUDe11hwD3198KwJ+9gbdHSx7deVv/0g9yM1k7Pc7d/
	achqvLb/YgOhnIiKzJ39va1jsBqorB/+c/G3a6ijrWvkCuNK6BS7JxD/uxj3RBai
	Qn4Sab0ZNMrd2AvrIbMBCvJL55Lmk29o0mER8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JCvOLNpZ52bS7EcsMndc36d/fDAqDnIG
	Tnhf6t9P7lBlDNTmAFJD0vZVaR1MjT2oPe+cixbK8PPH9gYPLjFIzKjMF9ELhzqF
	lQqGX94+KWzxLPv56baeO2lWkfXsUsN85Uh0/IgbPyO2p494yd5GWsX8uwIOazDm
	C3Zu/kxw2e4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 205D8296E4;
	Thu, 20 Jun 2013 21:41:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51BD4296E2;
	Thu, 20 Jun 2013 21:41:55 +0000 (UTC)
In-Reply-To: <7vk3lpwkt6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Jun 2013 19:57:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A079F46-D9F2-11E2-BE7D-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228543>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Without any configuration the current branch is pushed out, which
>> loosens the safety we implemented in the current 'safer upstream'.
>>
>> I am not convinced this is a good change.  I am not convinced this is
>> a bad change, either, yet, but this loosening smells bad.
>
> Provided that we would want to keep the "Push the current one to the
> same name but you have to have it set up as your integration source"
> safety for central workflow (which I am starting to think we
> should), we would want something like this on top of your entire
> series, I think.  The behaviour change can be seen in the revert of
> one test you made to the test that expects "simple" to fail due to
> the safety.

And with the small refactoring of setup_default_push_refspecs (the
important part being that we grab branch in this function, not in
its helper functions per push.default mode), branch.*.push can fall
out rather naturally, like this patch on top.


A footnote unrelated to this patch.

The function is_workflow_triangular() in the "how about this" patch
needs to be tweaked from the version I am responding to, in order to
take the case where fetch-remote is not defined into account, i.e.

    static int is_workflow_triagular(struct remote *remote)
    {
            struct remote *fetch_remote = remote_get(NULL);
            return (fetch_remote && fetch_remote != remote);
    }




 builtin/push.c | 18 +++++++++++++++++-
 remote.c       |  5 +++++
 remote.h       |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index f6c8047..a140b8e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -185,6 +185,15 @@ static void warn_unspecified_push_default_configuration(void)
 	warning("%s\n", _(warn_unspecified_push_default_msg));
 }
 
+static void setup_per_branch_push(struct branch *branch)
+{
+	struct strbuf refspec = STRBUF_INIT;
+
+	strbuf_addf(&refspec, "%s:%s",
+		    branch->name, branch->push_name);
+	add_refspec(refspec.buf);
+}
+
 static int is_workflow_triagular(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -194,7 +203,14 @@ static int is_workflow_triagular(struct remote *remote)
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
-	int triangular = is_workflow_triagular(remote);
+	int triangular;
+
+	if (branch->push_name) {
+		setup_per_branch_push(branch);
+		return;
+	}
+
+	triangular = is_workflow_triagular(remote);
 
 	switch (push_default) {
 	default:
diff --git a/remote.c b/remote.c
index e71f66d..e033fef 100644
--- a/remote.c
+++ b/remote.c
@@ -372,6 +372,11 @@ static int handle_config(const char *key, const char *value, void *cb)
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		} else if (!strcmp(subkey, ".push")) {
+			if (!value)
+				return config_error_nonbool(key);
+			free(branch->push_name);
+			branch->push_name = xstrdup(value);
 		}
 		return 0;
 	}
diff --git a/remote.h b/remote.h
index cf56724..84e0f72 100644
--- a/remote.h
+++ b/remote.h
@@ -138,6 +138,8 @@ struct branch {
 	struct refspec **merge;
 	int merge_nr;
 	int merge_alloc;
+
+	char *push_name;
 };
 
 struct branch *branch_get(const char *name);
