From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/12] attr: convert git_all_attrs() to use "struct git_attr_check"
Date: Tue, 17 May 2016 14:08:37 -0700
Message-ID: <xmqq7fesv1d6.fsf@gitster.mtv.corp.google.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-11-gitster@pobox.com>
	<xmqqeg90y5yz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 23:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2mES-0000wi-4P
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 23:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcEQVIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 17:08:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751346AbcEQVIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 17:08:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 29B6A1B050;
	Tue, 17 May 2016 17:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sBQjoHdkoxcltLSwz6soWAL8JU8=; b=NqMxaF
	NhzgPLxXWfTneNyZaBFUj7CM/iqABT9LsUJhL3u7blkvViCC0gbTGD1SdT3AA6XG
	R9Qjiz2gtrDQxvkMxtmFbQiXrR8HMDdz1SVxqWFfP7dfRdfxkWxceID9qvNdrzQe
	aMepIy15tZIezvXGKvaKu1GyKQVQZaHWcO0gY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m5tbKi4bSyZceqhhfvLqO3FmvUg/tmhq
	8rJwU+2buuiXkP3+nbkSKkTqIeXi0hHCpGZvhr/7G8NwSXDZY9u3PIzUTe1StNOC
	SP5uKQmSD1HB9E3vIoOWA/KGUdINAIeDzPl2y4KYCnEj+5knu4i22YDeRrpjFm/m
	ElIlkfsYmes=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 221741B04F;
	Tue, 17 May 2016 17:08:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C16D1B04E;
	Tue, 17 May 2016 17:08:39 -0400 (EDT)
In-Reply-To: <xmqqeg90y5yz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 17 May 2016 10:00:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8733B4AA-1C73-11E6-8B5C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294914>

Junio C Hamano <gitster@pobox.com> writes:

> Given that one of the two expected callers, namely, "check-attr" and
> Stefan's pathspec label magic, of this "alloc and then append" side
> of the API wants to have an access to git_attr(name), I think
> the function signature for this one should be updated to take not
> "const char *name" but instead take "struct git_attr *attr", i.e.

Perhaps this can be squashed into 12/12 to update the tutorial part
to cover this less often used form.

 Documentation/technical/api-gitattributes.txt | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 6f13f94..92fc32a 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -55,7 +55,11 @@ Querying Specific Attributes
 
 * Prepare `struct git_attr_check` using git_attr_check_initl()
   function, enumerating the names of attributes whose values you are
-  interested in, terminated with a NULL pointer.
+  interested in, terminated with a NULL pointer.  Alternatively, an
+  empty `struct git_attr_check` can be prepared by calling
+  `git_attr_check_alloc()` function and then attributes you want to
+  ask about can be added to it with `git_attr_check_append()`
+  function.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
@@ -112,6 +116,22 @@ static void setup_check(void)
 	}
 ------------
 
+To see how attributes in argv[] are set for different paths, only
+the first step in the above would be different.
+
+------------
+static struct git_attr_check *check;
+static void setup_check(const char **argv)
+{
+	check = git_attr_check_alloc();
+	while (*argv) {
+		struct git_attr *attr = git_attr(*argv);
+		git_attr_check_append(check, attr);
+		argv++;
+	}
+}
+------------
+
 
 Querying All Attributes
 -----------------------
