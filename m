From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Tue, 26 Aug 2014 07:03:03 -0400
Message-ID: <20140826110303.GA25736@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <53FA0054.5060808@gmail.com>
 <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com>
 <20140825130732.GD17288@peff.net>
 <xmqq8umcl0al.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:03:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMEWt-0004GC-KN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 13:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbaHZLDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 07:03:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:59083 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755724AbaHZLDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 07:03:06 -0400
Received: (qmail 11401 invoked by uid 102); 26 Aug 2014 11:03:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 06:03:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 07:03:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8umcl0al.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255887>

On Mon, Aug 25, 2014 at 02:36:02PM -0700, Junio C Hamano wrote:

> > I think you are right, and the patch is the right direction (assuming we
> > want to do this; I question whether there are enough elements in the
> > list for us to care about the size, and if there are, we are probably
> > better off storing the int and formatting the strings on the fly).
> 
> ;-)

Having now dug into this much further, the answers to those questions
are:

  1. Yes, we might actually have quite a lot of these, if you are
     bisecting a large range of commits. However, the code only runs
     when you are doing --bisect-all or skipping a commit, so probably
     nobody actually cares that much.

  2. It would be nicer to hold just an "int", but we are hooking into
     the log-tree decorate machinery here, which expects a string. We'd
     need some kind of decorate-like callback machinery from log-tree to
     do this right. It's probably not worth the effort.

> Among the flex arrays we use, some are arrays of bools, some others
> are arrays of object names, and there are many arrays of even more
> esoteric types.  Only a small number of them are "We want a struct
> with a constant string, and we do not want to do two allocations and
> to pay an extra dereference cost by using 'const char *'".

Yeah, I was working under the assumption that most of them were holding
a string. I just did a quick skim of the grep results for FLEX_ARRAY. Of
the 36 instances, 26 hold strings. 9 hold something else entirely, and 1
holds a char buffer that does not need to be NUL-terminated (so it
_could_ be handled by a similar helper, but using "%s" would be wrong).

So it's definitely the majority, but certainly not all. I decided to
look into this a little further, and my results are below. The tl;dr is
that no, we probably shouldn't do it. So you can stop reading if you
don't find this interesting. :)

> For them, by the time we allocate a struct, by definition we should
> have sufficient information to compute how large to make that
> structure and a printf-format plus its args would be the preferred
> form of that "sufficient information", I would think.

I was tempted to also suggest a pure-string form (i.e., just take a
string, run strlen on it, and use that as the final value). That would
make the variadic macro problem go away. But besides name_decoration,
there are other cases that really do want formatting.  For instance,
alloc_ref basically wants to do ("%s%s", prefix, name).

> The name "fmt_flex_array()", which stresses too much on the
> "formatting" side without implying that it is the way to allocate
> the thing, may be horrible, and I agree with you that without
> variadic macros the end result may not read very well.  Unless we
> have great many number of places we can use the helper to make the
> code to create these objects look nicer, I am afraid that the
> pros-and-cons may not be very favourable.

Yeah, reading my suggestion again, it should clearly be
alloc_flex_struct or something.

Here's a fully-converted sample spot, where I think there's a slight
benefit:

diff --git a/remote.c b/remote.c
index 3d6c86a..ba32d40 100644
--- a/remote.c
+++ b/remote.c
@@ -928,14 +928,30 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
 }
 
+static void *alloc_flex_struct(size_t base, size_t offset, const char *fmt, ...)
+{
+	va_list ap;
+	size_t extra;
+	char *ret;
+
+	va_start(ap, fmt);
+	extra = vsnprintf(NULL, 0, fmt, ap);
+	extra++; /* for NUL terminator */
+	va_end(ap);
+
+	ret = xcalloc(1, base + extra);
+	va_start(ap, fmt);
+	vsnprintf(ret + offset, extra, fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
 		const char *name)
 {
-	size_t len = strlen(name);
-	struct ref *ref = xcalloc(1, sizeof(struct ref) + prefixlen + len + 1);
-	memcpy(ref->name, prefix, prefixlen);
-	memcpy(ref->name + prefixlen, name, len);
-	return ref;
+	return alloc_flex_struct(sizeof(struct ref), offsetof(struct ref, name),
+				 "%.*s%s", prefixlen, prefix, name);
 }
 
 struct ref *alloc_ref(const char *name)

Obviously the helper is much longer than the code it is replacing, but
it would be used in multiple spots. The main thing I like here is that
we are dropping the manual length computations, which are easy to get
wrong (it's easy to forget a +1 for a NUL terminator, etc).

The offsetof is a little ugly. And the fact that we have a pre-computed
length for prefixlen makes the format string a little ugly.

Here's a another example:

diff --git a/attr.c b/attr.c
index 734222d..100c423 100644
--- a/attr.c
+++ b/attr.c
@@ -89,8 +89,8 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 	if (invalid_attr_name(name, len))
 		return NULL;
 
-	a = xmalloc(sizeof(*a) + len + 1);
-	memcpy(a->name, name, len);
+	a = alloc_flex_array(sizeof(*a), offsetof(struct git_attr, name),
+			     "%.*s", len, name);
 	a->name[len] = 0;
 	a->h = hval;
 	a->next = git_attr_hash[pos];

I think this is strictly worse for reading. The original computation was
pretty easy in the first place, so we are not getting much benefit
there. And again we have the precomputed "len" passed into the function,
so we have to use the less readable "%.*s". And note that offsetof()
requires us to pass a real typename instead of just "*a", as sizeof()
allows (I suspect passing "a->name - a" would work on many systems, but
I also suspect that is a gross violation of the C standard when "a" has
not yet been initialized).

So given that the benefit ranges from "a little" to "negative" in these
two examples, I'm inclined to give up this line of inquiry.

-Peff
