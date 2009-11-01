From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sat, 31 Oct 2009 21:27:17 -0700
Message-ID: <7v8weq50pm.fsf@alter.siamese.dyndns.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Samium Gromoff <_deepfire@feelingofgreen.ru>
X-From: git-owner@vger.kernel.org Sun Nov 01 05:27:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4S2d-0004WZ-AW
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 05:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbZKAE13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 00:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbZKAE12
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 00:27:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZKAE12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 00:27:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AD618DA52;
	Sun,  1 Nov 2009 00:27:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wuhkc9UvDJneQTwXSHi/FQ9ekrU=; b=XhL3UP
	sWhfRUaHGurtMZcnRZWZXLa/qpSuKwhJCwLaa0jZWCCDgGEK9kP8kJrJ34nHUdHL
	YHbcE7UL2u/u2K2sSQ3Gs1/JQWHhJS85UPcXMh6IVeF+L/uoIn5sKnKwMEgh5MbX
	jdL+pdkYxxHbigHBLK0rRRivdfmVfW4LILN/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a+8OUeYxEBBpNgiG2YUqhpE4FHk9WaOP
	G/eLjRCuChtfcdzympKxEY4YJkBwWlQT2Hbwh5QvK37caUwlOAH8nFD7PrpWs+/c
	sYq4ETJ1GkWfQ1QGnh93lvXQWrqfWMCcineemGYDcUxW883cvGR/zDOA0eexY7yp
	YGBRi51XPJA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 428C08DA4C;
	Sun,  1 Nov 2009 00:27:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C0FF8DA4B; Sun,  1 Nov 2009
 00:27:18 -0400 (EDT)
In-Reply-To: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
 (Samium Gromoff's message of "Sun\, 01 Nov 2009 01\:07\:02 +0300 \(MSK\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DBC75774-C69E-11DE-B4C7-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131864>

Samium Gromoff <_deepfire@feelingofgreen.ru> writes:

> Attached is the SEGV bugreport I sent to debian.

Thanks for a report.

There are two issues.

 * transport-helper.c::get_helper() assumes that the transport structure
   always has its remote member filled and it can get name out of it.
   This is the segv in the report.

 * Even if we work around the above issue, the helper subprocess (in this
   case, remote-curl helper) insists on being inside a git repository,  To
   satisfy ls-remote request, you do not have to be in one.

Attached is a minimum fix/work around, but this is done without being very
familiar with the current assumptions in the codepaths involved.

Issues I want area experts to consider before coming up with the final fix
are:

 - Should we fix get_helper() in transport-helper.c, instead of touching
   ls-remote.c like this patch does?

   This issue really boils down to this question: is it valid for a
   transport to have NULL in its remote field, and should all the code
   that touch transport be prepared to deal with such a transport
   structure?

 - When helping to handle ls-remote request, there is no need for the
   helper to know anything about the local state.  We probably shouldn't
   even run setup_git_directory_gently() at all in this case.  But when
   helping other kinds of request, the helper does need to know where our
   repository is.

   In general, what should the initial environment for helpers be?  Should
   they assume that they have to figure out where the git repository is
   themselves (in other words, should they assume they cannot rely on
   anything the caller does before they are called?  Would the caller
   generally have done the usual repo discovery (including chdir() to the
   toplevel), and there are some set of assumptions they can make?  If so
   what are they?


 builtin-ls-remote.c |    2 +-
 remote-curl.c       |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..a8d5613 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -86,7 +86,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			pattern[j - i] = p;
 		}
 	}
-	remote = nongit ? NULL : remote_get(dest);
+	remote = remote_get(dest);
 	if (remote && !remote->url_nr)
 		die("remote %s has no configured URL", dest);
 	transport = transport_get(remote, remote ? remote->url[0] : dest);
diff --git a/remote-curl.c b/remote-curl.c
index ad6a163..7c83f77 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -81,8 +81,9 @@ int main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	const char *url;
 	struct walker *walker = NULL;
+	int nongit = 0;
 
-	setup_git_directory();
+	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		fprintf(stderr, "Remote needed\n");
 		return 1;
