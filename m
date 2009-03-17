From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
 lengths)
Date: Mon, 16 Mar 2009 23:27:42 -0700
Message-ID: <7v8wn4u0ip.fsf@gitster.siamese.dyndns.org>
References: <d8c371a80903162215k4c27762cva650ea64d7850afa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Amos King <amos.l.king@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 07:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjSnf-0006hi-Qi
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 07:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbZCQG1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 02:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbZCQG1u
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 02:27:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbZCQG1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 02:27:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7915640F;
	Tue, 17 Mar 2009 02:27:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 076F6640E; Tue,
 17 Mar 2009 02:27:43 -0400 (EDT)
In-Reply-To: <d8c371a80903162215k4c27762cva650ea64d7850afa@mail.gmail.com>
 (Amos King's message of "Tue, 17 Mar 2009 00:15:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBA10076-12BC-11DE-B6F4-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113424>

Amos King <amos.l.king@gmail.com> writes:

> Junio,
>
> I'm working with Mike on the http auth stuff, and I was testing out
> your patch.  I can get it to work for fetch but push is giving me some
> grief.  Looking through the code I noticed that online 219 of
> http-push.c that http_init is being called with NULL instead of a
> remote.  If I pass in the remote then there is no remotre-url.  I've
> been digging around and can't find where or when that is being set.
> It has been a while since I worked with C but I'd love to jump in and
> help out here.  Can you point me in the right direction to get the
> remote->url[0] set for the http_auth_init to use?

Daniel is the primary culprit who introduced the transport abstraction,
and I think he muttered something about his work-in-progress that involves
in some change in the API.  Perhaps he has some insights here?

Naah.  I forgot that the transport abstraction on the fetch side is much
more integrated but curl_transport_push() simply launches http-push.c that
has a world on its own.  Worse yet, "remote" in http-push.c is not even
the "struct remote"; it is something private to http-push.c called "struct
repo".

I am not sure how much work would be involved in converting (or if it is
even worth to convert) http-push.c to fit better into the transport API,
but if that is feasible, it might be a better longer-term solution.
Right now, builtin-push.c does all the remote inspection and when
http-push is called, the latter gets the information at the lowest level
only; the higher level information such as what nickname was used by the
user to initiate the "git push" process and whether the refspecs came from
the command line or from the config are all lost, which is quite sad.

But as a much lower impact interim solution, I suspect that you can fake a
minimally usable remote.  The http_push() codepath only cares about
remote->http_proxy and remote->url settings as far as I can tell, so
perhaps you can start (with a big warning that the remote you are creating
is a fake one) by filling the absolute minimum?

That is, something along these lines (this comes on top of an obvious
patch that renames existing "remote" variable in http-push. to "repo").

diff --git a/http-push.c b/http-push.c
index dfbb247..f04ac74 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2197,6 +2197,7 @@ int main(int argc, char **argv)
 	int new_refs;
 	struct ref *ref;
 	char *rewritten_url = NULL;
+	struct remote *remote;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -2258,12 +2259,14 @@ int main(int argc, char **argv)
 	if (!repo->url)
 		usage(http_push_usage);
 
+	remote = remote_get(repo->url);
+
 	if (delete_branch && nr_refspec != 1)
 		die("You must specify only one branch name when deleting a remote branch");
 
 	memset(remote_dir_exists, -1, 256);
 
-	http_init(NULL);
+	http_init(remote);
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
