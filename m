From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Fri, 28 Aug 2015 09:39:32 -0700
Message-ID: <xmqqoahr2wqj.fsf@gitster.mtv.corp.google.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
	<1440618365-20628-3-git-send-email-dturner@twopensource.com>
	<xmqqwpwh21ky.fsf@gitster.dls.corp.google.com>
	<1440627031.26055.5.camel@twopensource.com>
	<1440627545.26055.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:39:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVMgl-0002F2-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 18:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbH1Qjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 12:39:35 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33314 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbH1Qje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 12:39:34 -0400
Received: by padfo6 with SMTP id fo6so29382341pad.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lgrRxJuvqMOEtBvHROWoUaEXq91OYqjgOwmTLLwgNYs=;
        b=wanJXfTS+H4GAENyyer2n2aAy5BUf04mPuHgGi1YQ2B/rOG5NX/6rzUKVcKeLbRfeP
         UnzTEmQjIO7sJGJ9P9xa71aZcT+PueLDUTHVVzqJdnrbMaOlYw8aBCfLCENAK6HjVjP8
         LuWoS7YS4LfCqjSjAqzEhhC3DGGKYmpkQetsENo3mUy63t43hlNs0YNIJrkG1oXHYGbc
         VghodgHowbTe2LaaK921UMLJCUPnZAoy4Pwd2C0Nepictz4ZNxR6922gJtBRut2V2mXZ
         667bUO3Bx3g4q9NsKDndo3pXy5Vely/2cdpjxfs5k+D/WN1xFtKFWkTJEiZVdOiEOkxX
         ryjw==
X-Received: by 10.68.205.232 with SMTP id lj8mr16982414pbc.116.1440779974060;
        Fri, 28 Aug 2015 09:39:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id k8sm6242197pdn.96.2015.08.28.09.39.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 09:39:33 -0700 (PDT)
In-Reply-To: <1440627545.26055.8.camel@twopensource.com> (David Turner's
	message of "Wed, 26 Aug 2015 18:19:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276727>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2015-08-26 at 18:10 -0400, David Turner wrote:
>> On Wed, 2015-08-26 at 14:15 -0700, Junio C Hamano wrote:
>> > > + * For example, consider the following set of strings:
>> > > + * abc
>> > > + * def
>> > > + * definite
>> > > + * definition
>> > > + *
>> > > + * The trie would look look like:
>> > > + * root: len = 0, value = (something), children a and d non-NULL.
>> > 
>> > "value = NULL", as there is no empty string registered in the trie?
>> 
>> Indeed.
>> 
>> > > + *    a: len = 2, contents = bc
>> > 
>> > "value = NULL" here, too (just showing I am following along, not
>> > just skimming)?
>> 
>> Yep.
>
> No, wait. value should be non-NULL, since abc is in the string set. 

True.  Here is what I came up with on top of your original.  



 path.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 4100ba6..ce0530b 100644
--- a/path.c
+++ b/path.c
@@ -133,12 +133,13 @@ struct common_dir common_list[] = {
  * definition
  *
  * The trie would look look like:
- * root: len = 0, value = (something), children a and d non-NULL.
- *    a: len = 2, contents = bc
- *    d: len = 2, contents = ef, children i non-NULL, value = (something)
+ * root: len = 0, children a and d non-NULL, value = NULL.
+ *    a: len = 2, contents = bc, value = (data for "abc")
+ *    d: len = 2, contents = ef, children i non-NULL, value = (data for "def")
  *       i: len = 3, contents = nit, children e and i non-NULL, value = NULL
- *           e: len = 0, children all NULL, value = (something)
- *           i: len = 2, contents = on, children all NULL, value = (something)
+ *           e: len = 0, children all NULL, value = (data for "definite")
+ *           i: len = 2, contents = on, children all NULL,
+ *              value = (data for "definition")
  */
 struct trie {
 	struct trie *children[256];
