From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] fast-export: Omit tags that tag trees
Date: Sat, 20 Jun 2009 12:01:00 -0600
Message-ID: <51419b2c0906201101u2f8e6981q84ab7acc13dc9135@mail.gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
	 <1245472623-28103-2-git-send-email-newren@gmail.com>
	 <20090620173128.GE31022@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 20 20:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI4sK-00015Y-7l
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 20:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbZFTSBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jun 2009 14:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757174AbZFTSA7
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 14:00:59 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:59730 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbZFTSA6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jun 2009 14:00:58 -0400
Received: by qyk1 with SMTP id 1so204866qyk.33
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8SMUUrElxsb2LmlPHaCX0HyIxGEhjT+leHvWrUCQmUk=;
        b=eojjAke7o3iLAQGF+wuV1DDjZOBt8frIJsQH3BHyNIqJ6UEaUdh/E7RxWUWNbbRaWh
         usHhvsr9/Y0lUdvTUP1flLUTzWizJcRAvGN4UCxcsq7MxUjNjLq9o07bTD3KP/YFmHeV
         6qOKrKu+/qi9ehIWtzQsgdKSTlfgvPMj8s/jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A906yQv4UqCw1mzH/Tmdt2zr79EUGCzjQfyIGtUGXvZnxTizu/Ktw6wTkaRVEuGC06
         +ryOI+xqc9i51NOa20oat1VLcTw78EQBSthLWdw1wjGoa93Ae23LWu5uVbSwjGizkyAo
         +A3PDWGWnTC2+6TDhhyOYHQWCJW96ZC7UEvIQ=
Received: by 10.229.99.66 with SMTP id t2mr812230qcn.38.1245520861274; Sat, 20 
	Jun 2009 11:01:01 -0700 (PDT)
In-Reply-To: <20090620173128.GE31022@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121948>

Hi,

On Sat, Jun 20, 2009 at 11:31 AM, Jeff King<peff@peff.net> wrote:
> Do we really want to disallow tags pointing to trees? There is at lea=
st
> one well-known case in use (kernel v2.6.11).
>
> Also, (and I haven't investigated at all), this sounds like the same
> issue we have with tags pointing to tags. IOW, everything referenceab=
le
> should be given a mark, but it is not currently. I posted a "how abou=
t
> this" patch for the tag case here:
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/119245
>
> but I never got around to following it up with tests. Could you do
> something similar for the tree case?

I don't see how we could do something similar for the tree case
without making some significant change to the output/input of both
fast-export and fast-import.  Tag objects are part of the output of
fast-export, thus we can add a mark line to give the object a name and
thus provide us a valid mark we can make the outer tag point to.
Trees are not output by fast-export (other than implicitly by
including files in commits), so we have nothing to point such a tag
at.  If we were to do something like use the full sha1sum instead of
marks in such a case (which git-fast-import should currently accept),
then (a) we'd break exporting a repository limited by path ('git
fast-export master -- libfoo"), and (b) we'd break interoperation with
other tools like bzr-fast-import (or a possible future git that uses a
different checksum).

If someone wanted to tackle modifying the output/input syntax of
fast-export and fast-import, maybe something could be done here, but
my patch just tries to make things operate sanely within the given
documented limitations (as found in the git-fast-export manpage --
"Since 'git-fast-import' cannot tag trees, you will not be able to
export the linux-2.6.git repository completely, as it contains a tag
referencing a tree instead of a commit.").


Elijah
