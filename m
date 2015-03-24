From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: Re: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Mon, 23 Mar 2015 20:09:50 -0400
Message-ID: <87r3sfz25t.fsf@gmail.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
	<1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
	<xmqqlhiwredj.fsf@gitster.dls.corp.google.com>
	<xmqq8uewp183.fsf@gitster.dls.corp.google.com>
	<87egons4du.fsf@gmail.com>
	<xmqqpp87mfqx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 01:09:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaCPa-0005Rr-9L
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 01:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbCXAJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 20:09:33 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33017 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbCXAJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 20:09:32 -0400
Received: by qgfa8 with SMTP id a8so172409877qgf.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AmQkuyAMKyF1Op41/JgN4W2Yri/38/tT/fXrqWCHxWY=;
        b=GjTXyyidfc1j4FJagxpwUNPYlQ+m1DTkGMc/Gi+BGiYdKxrWxFmeA8PbtKXbtRdZPR
         l2RGS4BhADGDOsSEnE5h2EC+yfYnc28i/1CQxqzJ3WfzZLzsrgIJkhxV6FyL+pZ4u6sH
         pyuCL8dTYTQOMLtokVzV/7uhp820B7qOlJdL+tCocwNWG50FTrDZ7MAOoocIs0kZP1hK
         nh6JjuUbQaHoDJza6kPUxXRc6LmEFNcLRff50poIt+g0c2pNd5Q4FnecrRFYtLYfOLW7
         DZESFUUJgj91mqF794ZtSCuLJxtnDlIZaAWtulUxOPoEagDzyILUk3nUzBljlgOvNnBM
         jZMw==
X-Received: by 10.55.18.217 with SMTP id 86mr3692899qks.5.1427155771693;
        Mon, 23 Mar 2015 17:09:31 -0700 (PDT)
Received: from fujitsu ([24.157.147.86])
        by mx.google.com with ESMTPSA id h6sm1598625qgh.32.2015.03.23.17.09.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 17:09:30 -0700 (PDT)
In-Reply-To: <xmqqpp87mfqx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 17 Mar 2015 15:16:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266168>

On Tue, Mar 17 2015 at 06:16:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I also notice that handle_revision_arg() would die() by calling it
> directly or indirectly via verify_non_filename(), etc., but the
> caller actually is expecting it to silently return non-zero when it
> finds an argument that cannot be interpreted as a revision or as a
> revision range.  
>
> If we feed the function a string that has ".." in it, with
> cant_be_filename unset, and if that string _can_ be parsed as a
> valid range (e.g. "master..next"), we would check if a file whose
> name is that string and die, e.g.
>
>     $ >master..next ; git log master..next
>     fatal: ambigous argument 'master..next': both revision and filename
>
> If we swap the order to do the "revision" first before "option",
> however, we would end up getting the same for a name that begins
> with "-" and has ".." in it.  I see no guarantee that future
> possible option name cannot be misinterpreted as a range to trigger
> this check.
>
If I'm understanding correctly, the problem of checking revisions before
arg is that an option fed to handle_revision_arg() might die() before getting
checked as an option in cases where a file with the same name exists?

But doesn't verify_non_filename() already return silently if arg begins
with "-"? It die() only after making that check.

If an option with ".." in it such as -$opt..ion is really given to
handle_revision_arg() then verify_non_filename should not be a problem.

> But "git cmd -$option" for any value of $option does not have to be
> disambiguated when there is a file whose name is "-$option".  The
> existing die()'s in the handle_revision_arg() function _will_ break
> that promise.  Currently, because we check the options first,
> handle_revision_arg() does not cause us any problem, but swapping
> the order will have fallouts.
>

The only other way handle_revision_arg() can die() is if given a ".."
range, either revisions return null when passed their sha1 to
parse_object().

So something like you proposed earlier:

      if(try to see if it is a revision or a revision range) {
              /* if failed ... */
              if (starts with '-') {
                      do the option thing;
                      continue;
              }
              /*
               * args must be pathspecs from here on.
               * We already checked that rev arg cannot be
               * interpreted as a filename at this point
               */
              if(dashdash)
                      verify_filename()
                     
      } else {
              got_rev_arg = 1;
      }

should work. I'm still getting familiar to how it works so I might be missing
something but shouldn't this be fine? At least concerning the possible fallouts
that you've raised.

> If we want to really do the swapping (and I think that is the only
> sensible way if we wanted to allow "-" and any extended SHA-1 that
> begins with "-" as "the previous branch"), I think the "OK, it looks
> like a revision (or revision range); as we didn't see dashdash, it
> must not be a filename" check has to be moved to the caller, perhaps
> like this:
>
> 	if (try to see if it is a revision or a revision range) {
>         	/* failed */
>                 ...
> 	} else {
>         	/* it can be read as a revision or a revision range */
>                 if (!seen_dashdash)
> 			verify_non_filename(arg);
> 		got_rev_arg = 1;
> 	}
>
If what I'm saying makes sense, then verify_non_filename(arg) would be
already working as intended in handle_revision_arg(), so moving it to
the caller wouldn't be necessary.

> The "missing" cases should also silently return failure and have the
> caller deal with that.
