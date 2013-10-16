From: John Keeping <john@keeping.me.uk>
Subject: Re: Pull and fetch don't honor `--progress` flag
Date: Wed, 16 Oct 2013 21:12:10 +0100
Message-ID: <20131016201210.GR27238@serenity.lan>
References: <48AC4CE6F0887542B2A5E28E4E7A929740FA5349A9@Viper-RSG.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Jacobs, Todd" <todd.jacobs@cognex.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 22:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWXS9-0007mA-B6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 22:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761522Ab3JPUMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 16:12:17 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:33361 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760150Ab3JPUMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 16:12:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9F832606528;
	Wed, 16 Oct 2013 21:12:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1GQ0ED5DNPdo; Wed, 16 Oct 2013 21:12:16 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 44C3E60651D;
	Wed, 16 Oct 2013 21:12:16 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 33E3E161E170;
	Wed, 16 Oct 2013 21:12:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mref5dMTLXpB; Wed, 16 Oct 2013 21:12:15 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 16F4D161E4F9;
	Wed, 16 Oct 2013 21:12:12 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <48AC4CE6F0887542B2A5E28E4E7A929740FA5349A9@Viper-RSG.pc.cognex.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236261>

On Wed, Oct 16, 2013 at 03:50:51PM -0400, Jacobs, Todd wrote:
> When I use the `--progress` flag with the push command, I get transfer-speed statistics like this:
> 
>     $ git push -progress origin master 2>&1 | tee /tmp/push
>     Counting objects: 30, done.
>     Compressing objects: 100% (20/20), done.
>     Writing objects: 100% (30/30), 9.02 MiB | 206.00 KiB/s, done.
>     Total 30 (delta 0), reused 0 (delta 0)
> 
> This also works similarly with clone:
> 
>     $ git clone --progress "$url" foo.git 2>&1 | tee /tmp/clone
>     Cloning into 'foo.git'...
>     remote: Counting objects: 61, done.
>     remote: Compressing objects: 100% (43/43), done.
>     remote: Total 61 (delta 3), reused 0 (delta 0)
>     Receiving objects: 100% (61/61), 15.22 MiB | 473.00 KiB/s, done.
>     Resolving deltas: 100% (3/3), done.
>     Checking connectivity... done
> 
> However, even though pull and fetch also have the same flag documented, git never reports any network statistics at all. For example:
> 
>     $ git pull --progress origin master 2>&1 | tee /tmp/pull
>     remote: Counting objects: 5, done.
>     remote: Compressing objects: 100% (3/3), done.
>     remote: Total 3 (delta 1), reused 0 (delta 0)
> 
> This is repeatable with both Git 1.7.9 and Git 1.8.4.1 running under Cygwin. Is this a bug? If not, how can I make fetch and pull cough up throughput statistics?

Does it make a difference how you invoke "git fetch"?  From a quick look
at the code, "git fetch" with no remote or refspec should display
progress data, but if you specify "--all" or a remote and refspec then
it won't.

The following patch (untested) will fix it if that is the case:

-- >8 --
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..487381e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -952,6 +952,10 @@ static void add_options_to_argv(struct argv_array *argv)
 		argv_array_push(argv, "-v");
 	else if (verbosity < 0)
 		argv_array_push(argv, "-q");
+	if (progress > 0)
+		argv_array_push(argv, "--progress");
+	else if (progress == 0)
+		argv_array_push(argv, "--no-progress");
 
 }
 
