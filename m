From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 12/13] remote.c: refactor get_remote_ref_states()
Date: Mon, 23 Feb 2009 02:55:32 -0500
Message-ID: <76718490902222355v7510d2f9p51ade61d1f257146@mail.gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
	 <885507eaf920f6b60727db7e712da3560a7fd4c5.1235368324.git.jaysoffian@gmail.com>
	 <20090223065048.GC24517@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbVgU-0006No-0k
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbZBWHzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbZBWHze
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:55:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:48083 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZBWHzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 02:55:33 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1834593rvb.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ja0tRkEUiLlFpmnM5LHu2fEw0JHsgwWb4WygSK4YNrI=;
        b=cxW+1/yh44Dja5ff4KePhlUvgYCd5dljpe6eNmpXEY4HmirVA7C6ZoYxeODOeT/fXK
         V3/ynGFiEgFGwkFh9GOVt4MhM/z24J/gP/PRWXeOJHrqYkaANE9glMOvj/tT8QVGYnpp
         HmbAGQWDMMrlwBDTCvsMVGm5bcDMDxyTRGQBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BbrApAHmwbLzsoultGSUMU+cceDBJyPdQJ9AjTOyedlbCGle9EhipaxuW9quLbcMYU
         0HmGSMbglptT0TKupcnF4GFc53mhp8wqSTtECkr3JDCk4V5RevNG/e+g1fUiRq8SXRTE
         jER7kQlDlIsLTrL4nm5NwAPIlabkQnFIV5eko=
Received: by 10.141.210.21 with SMTP id m21mr1908514rvq.204.1235375732736; 
	Sun, 22 Feb 2009 23:55:32 -0800 (PST)
In-Reply-To: <20090223065048.GC24517@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111116>

On Mon, Feb 23, 2009 at 1:50 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 23, 2009 at 01:29:00AM -0500, Jay Soffian wrote:
>
>> get_remote_ref_states() has three callers, but each is interested in
>> slightly different information. Give it a bit-field flag so that callers
>> can specify which pieces of information they need.
>
> Hmph. I think this is probably an indication that
> get_remote_ref_states() should really be 3 functions:
>
>  common_stuff();
>  query_one();
>  query_two();
>
> and then callers can choose the subset they are interested in.
>
> Which is really more or less equivalent; it just seems like extra
> obfuscation to have a single function with a bit-field.

I see your hmph and raise you a hmph. :-)

Well, I _had_ tried as you suggested first, and thought it yuckier. It
would actually be more like:

caller1() {
  setup_for_get();
  get_thing_one();
}

caller2() {
  setup_for_get();
  get_thing_two();
}

caller3() {
  if (query) {
     setup_for_get();
     get_thing_one();
     get_thing_two();
     get_thing_three();
} else {
     get_thing_one_noquery()
     get_thing_two_noquery();
}

As opposed to:

caller1() {
  get_things(ONE)
}

caller2() {
  get_things(TWO)
}

caller3() {
  things = 0;
  if (query)
     things = (ONE|TWO|THREE)
  get_things(things)
}

I'm not sure why passing a flag saying what you want is obfuscating.
Also, I did find other places in git that do this sort of thing (e.g.,
get_remote_heads).

(Awaiting Junio's lucid reply explaining why my justification is bogus.) :-)

j.
