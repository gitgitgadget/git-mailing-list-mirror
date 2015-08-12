From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 15:51:50 -0700
Message-ID: <CA+P7+xqa-DFHhoCvi4qRhPNGDpAmb9T3k28GOwuW6gzc4VfPbQ@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
 <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
 <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com> <CALKQrgf2hdvNExVbvnP5sVUM4sEh7thj9HLw93LbYWSStNjeYg@mail.gmail.com>
 <CA+P7+xrQnrQdE3OOhdc2-2__V3Huzc+HfGEXKBZULy2JkQR37Q@mail.gmail.com>
 <CA+P7+xp0zhqM4CHmFpKuPyNMTx3DBxiLSOsiwz=byrfTEDj3sA@mail.gmail.com> <xmqqmvxwjfjb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPesZ-0002s3-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbbHLWwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:52:11 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35738 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbHLWwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:52:10 -0400
Received: by igbjg10 with SMTP id jg10so52930347igb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v343tMVu+dWjO8OMfFQAXjsTCFKCioodfuKIYQZbye0=;
        b=0WFXPInAZohI07fptuAaRuGJKl8b/ENGgyRpL9dV6sHseTuNVv14JqeS/7AEfKmSdo
         lKfDLi1iNasWpQCAyaKg3Q3alcm/nAjj/7mduossRKVAMzhadAACW7HA8ZyXRbHz3uaC
         tNWSFb/g3pWmaCpPleayz1MoqXMlH79Lxv2CS3xOB7fm/gIqcRZnyoPDjhdpAU0hCkvw
         4flcjtIE0sig+2Q98yrgnHmgcK1mYRPE3bF6T/tX0KUkf9MmFOc++Qczjb0BwfkV5Uy8
         sIsuVqSHjvcreuZryk9k2X7JNWkI0NX9I9cyfbnGPfr7KqLqE1dpdydmulH7WUSGqZhd
         GTVA==
X-Received: by 10.50.124.97 with SMTP id mh1mr177292igb.92.1439419929515; Wed,
 12 Aug 2015 15:52:09 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 15:51:50 -0700 (PDT)
In-Reply-To: <xmqqmvxwjfjb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275827>

On Wed, Aug 12, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I spoke to soon. We have an "init_notes_check" function which shows
>> that it does refuse to merge outside of refs/notes/* It prevents all
>> notes operations outside of refs/notes
>
> OK.  Then it is OK to limit notes.<ref>.mergestrategy so that <ref>
> refers to what comes after refs/notes/, because we will not allow
> merging to happen outside the hierarchy.
>
> If you are planning to break that promise, however, <ref> must be
> always spelled fully (i.e. with refs/notes/ prefix for those inside
> the hierarchy) to avoid ambiguity.  Otherwise it will be hard to
> interpret a configuration that does something like this (note that
> these could come from multiple places, e.g. $HOME/.gitconfig and
> $GIT_DIR/config):
>

Agreed. Today, we do not allow any notes operations at all that
function outside of refs/notes/*

I suggest we enforce that all configs for merge strategy must be the
unqualified notation, and not allow the variance of refs/notes/* and
such that DWIM does on the command line.

>     [notes "commits"]
>         mergestrategy = concatenate
>     [notes "notes/commits"]
>         mergestrategy = cat_sort_uniq
>     [notes "refs/notes/commits"]
>         mergestrategy = overwrite
>
> The three entries in the above example obviously are all meant to
> refer to the same refs/notes/commits notes tree, and the usual "last
> one wins" rule should apply.  But with the recent git_config_get_*()
> interface, you cannot tell which one among them was given the last,
> overriding the previous entries.

Ya, I'd like to avoid this if possible.

Regards,
Jake
