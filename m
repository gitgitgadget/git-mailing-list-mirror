From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Wed, 3 Oct 2012 22:23:04 +0700
Message-ID: <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 17:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQox-0006tz-1F
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 17:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161Ab2JCPXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 11:23:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57570 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933157Ab2JCPXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 11:23:35 -0400
Received: by ieak13 with SMTP id k13so17438652iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P05sfd7TkSXFqybEa46Z30i4+QL65PYZiKG9CGrhckY=;
        b=CL518GlI7X2ATUUUzabcxM/QMpaTp2PGK9H8DTgh4uJ02igO9d6+oQzkEex7t0KS48
         nddN2t7dA3lFqn0y0FDMcXQravCEOyDaOC97KYR5tJ4Mn5LW6i6ITwuvw/ENEzlebQJb
         s9lM5tPD6PY6VdUZfZYhTtyHxlw4QfNQVcnOh5iXe7JSznIG/vjbEU8KEZPxTzVwt0rT
         bEHwfWYdRh8/eLRn1CPQPSwRN6OjEz0RnNaX4xh/ncWJdIk0rrS6XTiS4/n2aFgNrWr0
         rAXy9HxbDjYVJAKdZ6LT3RdkRQuIUXlFVOBXI5EZZWoNryztXiUNpDr6dvbfwJSb+jB5
         dKKg==
Received: by 10.50.53.199 with SMTP id d7mr2179862igp.47.1349277815349; Wed,
 03 Oct 2012 08:23:35 -0700 (PDT)
Received: by 10.64.23.197 with HTTP; Wed, 3 Oct 2012 08:23:04 -0700 (PDT)
In-Reply-To: <7vmx045umh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206907>

On Wed, Oct 3, 2012 at 6:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/wildmatch (2012-09-27) 5 commits
>  - Support "**" in .gitignore and .gitattributes patterns using wildmatch()
>  - Integrate wildmatch to git
>  - compat/wildmatch: fix case-insensitive matching
>  - compat/wildmatch: remove static variable force_lower_case
>  - Import wildmatch from rsync
>
>  Allows pathname patterns in .gitignore and .gitattributes files
>  with double-asterisks "foo/**/bar" to match any number of directory
>  hiearchies.
>
>  It was pointed out that some symbols that do not have to be global
>  are left global. I think this reroll fixed most of them.
>
>  Will merge to 'next'.

Just a bit of finding lately, in case you want to postpone the merge.

There's an interesting case: "**foo". According to our rules, that
pattern does not contain slashes therefore is basename match. But some
might find that confusing because "**" can match slashes, as opposed
to ordinary wildcards which cannot. So we could either go with our
rules and consider "**" just like "*" in this case (do we need
document clarification?), or redefine it that the presence of "**"
implies FNM_PATHNAME.

I think the latter makes more sense. When users put "**" they expect
to match some slashes. But that may call for a refactoring in
path_matches() in attr.c. Putting strstr(pattern, "**") in that
matching function may increase overhead unnecessarily.

The third option is just die() and let users decide either "*foo",
"**/foo" or "/**foo", never "**foo".
-- 
Duy
