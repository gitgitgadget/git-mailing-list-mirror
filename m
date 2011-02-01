From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [1.8.0] Remote tag namespace
Date: Tue, 1 Feb 2011 17:44:50 +0700
Message-ID: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 11:45:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkDjk-0004J0-Bt
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 11:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab1BAKpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 05:45:23 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57254 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab1BAKpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 05:45:22 -0500
Received: by wwa36 with SMTP id 36so6869926wwa.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 02:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=E8969MPAB+J4jS5umAZVaD4FmVWBNIXAq5rLqfqxa70=;
        b=Cq5Qe3/E2kgihp4x3bnO4fYrA2HZ35/QJuJO7FbThVyNOQhzqwthXauzZLhTFHYexO
         U5tujVQw1tTHM7TxjLI5wW1RpuvpiLqb6zSACkiTvg/AijwxLYRy5H44WpUP6+DVzsXR
         3RK0SiMTrQ8/Z0SjJMII58I5/sGfI7URppEDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=o3y05v6T0LE36IX9BQ7IP4qSNO5Eq/DchUYOpvwLwC7UO65jKqortm/Co1xFhUZiUV
         7bWlgH2TyMvqEp+975WqeqjmWLollYeuRBwwJSeY1srLXQP3I5NWgS+CyVsdSUwy7+Mc
         3FthG6DgjjJAegOqU6s7uVO+mn4pHUecvAZP4=
Received: by 10.216.52.134 with SMTP id e6mr1137721wec.49.1296557120789; Tue,
 01 Feb 2011 02:45:20 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 02:44:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165799>

On Tue, Feb 1, 2011 at 11:16 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Tue, 1 Feb 2011, Nguyen Thai Ngoc Duy wrote:
>> Another random wish, which does not come with a proposal. How about
>> tag namespace (ie. tags from a remote stay in remote namespace)?
>
> Please make this into a proper proposal. =C2=A0this would be indeed a=
 huge
> improvement.

OK I'm not familiar with tag code, but I can try.

Proposal:

Reserve refs/remote-tags namespace to store tags from remotes. Its
structure is the same as in refs/remotes. When pulling tags, put them
in refs/remote-tags/<remote> instead of refs/tags.
Tag dereference code will be taught about refs/remote-tags with
similar deref order as in remote branches.

Config branch.*.globalTags (perhaps takes a pattern?) may be defined
to create refs/tags/* in addition to refs/remote-tags/<remote>/* when
fetching tags.

Migration plan:

refs/remote-tags will be used to store new tags unconditionally, which
means there will be duplicates with the already-fetched tags in global
namespace. Perhaps we can check if they point to the same sha-1, then
choose not to annoy users with ambiguous tag messages?

I suggest to add config compatibility.remoteTagNamespace, default to
false, which retains current behavior (i.e. also create tags in global
namespace in addition to refs/remote-tags). After 1.8.0 (or a few more
cycles) the default value becomes true. Users who wish to keep old
behavior can put "false" in their ~/.gitconfig.

After a few years, remove support for the config key. Unrecognized
compatibility.* keys will abort program. Users are forced to new
behavior. I don't know, we may want to start annoy users that have the
config key set a few cycles before we drop support.
--=20
Duy
