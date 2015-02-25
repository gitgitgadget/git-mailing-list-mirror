From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and export it.
Date: Wed, 25 Feb 2015 13:32:52 -0800
Message-ID: <xmqq61apoewr.fsf@gitster.dls.corp.google.com>
References: <54EDACC9.5080204@gmail.com>
	<1424862460-13514-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:33:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQjZn-0007CW-MY
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 22:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbbBYVc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 16:32:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752907AbbBYVcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 16:32:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 790183A0DA;
	Wed, 25 Feb 2015 16:32:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gH7U4jsaDI8TBYN66I/evxlws28=; b=Xqa0L/
	CDDt//T3j2wvwhTOACCAmaFEk+uXYGp3m2hnj5/qOywwhVYIZV/7UKofv9jHNtcl
	v9sRxl0iyeX9Snr2Fvy+VJxMM/ScrFLrVjIPRTzLj/D2T0kiV2qJcvM06GI5LoJX
	TqRGuI9PmMK++r1PQ3BblPmSrWeRI1EemVXno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wcp8YILWGaGJo73W6WNBjic/821frXPE
	N8qd8/KKRBd+AIbHEVFsl68seQvG58t6auECMxxNOswrYkowoV0gAX/CDWg0/rjX
	DsCwE9L0+Hm0kKQYB/98qZdpfoCJa8Ft1pBlGLnas7+19E0HhDuqNknr+UNSvXeI
	1Bfcu7uD3EM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 707EC3A0D9;
	Wed, 25 Feb 2015 16:32:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC9B63A0D8;
	Wed, 25 Feb 2015 16:32:53 -0500 (EST)
In-Reply-To: <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 25 Feb 2015 16:37:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB664A18-BD35-11E4-AFAA-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264415>

Karthik Nayak <karthik.188@gmail.com> writes:

> +int sha1_object_type_literally(const unsigned char *sha1, char *type)
> +{
> +	int status = 0;
> +	unsigned long mapsize;
> +	void *map;
> +	git_zstream stream;
> +	char hdr[32];
> +	int i;
> +
> +	map = map_sha1_file(sha1, &mapsize);
> +	if (!map)
> +		return -1;

I am not sure if it is a good idea to introduce a function with the
above signature and the semantics in the first place.  It is OK to
assume that objects with funny typenames only appear as loose
objects, but it is not OK for "cat-file --literally" to fail to work
on objects that are of kosher types.

What should "git cat-file --literally -t HEAD~2" do?  I think it
should say "commit" as long as my current history is at least 3
commits deep, even when my repository is fully packed.  But I
suspect the above code does not do that.  

Looking at how we collect information on normal objects, it may make
more sense to model this after sha1_loose_object_info(), with a
tweak to struct object_info datatype, and integrate it into
sha1_object_info_extended() may make more sense, perhaps along the
lines of the attached patch.

The new helper would mimick what sha1_loose_object_info() is doing,
in that it may be used to learn on-disk size, object size, typename
string (returned in oi->typename strbuf that is optional).  There is
no sensible value to stuff in oi->typep if the incoming object name
refers to the experimental invalid object, so perhaps you will store
OBJ_NONE or something there and the "cat-file --literally" would use
the oi->typename to learn the name of the "type".


 cache.h     | 1 +
 sha1_file.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index 4d02efc..72b7cfa 100644
--- a/cache.h
+++ b/cache.h
@@ -1296,6 +1296,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..2c0e83a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2568,6 +2568,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	munmap(map, mapsize);
 	if (oi->typep)
 		*oi->typep = status;
+	if (oi->typename && 0 < status && typename(status))
+		strbuf_add(oi->typename, typename(status));
 	return 0;
 }
 
@@ -2593,6 +2595,13 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	}
 
 	if (!find_pack_entry(real, &e)) {
+		/* Have we been asked to check possibly invalid ones? */
+		if ((flags & LOOKUP_LITERALLY) &&
+		    !sha1_object_info_literally(real, oi)) {
+			oi->whence = OI_LOOSE;
+			return 0;
+		}
+
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(real, oi)) {
 			oi->whence = OI_LOOSE;
