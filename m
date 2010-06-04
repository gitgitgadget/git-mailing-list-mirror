From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] branch: exit status now reflects if branch listing
 finds an error
Date: Thu, 3 Jun 2010 21:24:06 -0500
Message-ID: <20100604022405.GA26071@progeny.tock>
References: <20100603065527.GA23439@progeny.tock>
 <1275551282-21557-1-git-send-email-simo.melenius@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Simo Melenius <simo.melenius@iki.fi>
X-From: git-owner@vger.kernel.org Fri Jun 04 04:23:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKMZY-0007rh-UX
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 04:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab0FDCXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 22:23:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43738 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab0FDCXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 22:23:43 -0400
Received: by iwn37 with SMTP id 37so523720iwn.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JmipWL2wF44TjxvBsCvJMcowBu6c9yFOLz4jbYAfMZE=;
        b=aJnS7ssh25QM6x8eAzUSQ1LRxvcn606TqshVQ9GMSH/Z3PA42zJPTEDrMOVGqLGwqB
         znoRyGQ0dsrBx4lee1EjndJxUHVrMzxybaSNJp3bh3u58pyb9bB767Lq29hjq/rNKa0l
         dLRU2sogls8/bz0p/gvXck9hMNlW1b6b6a9D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bmqO+jjmPVOqLEWhPuKWLUDRt3kq0eYWIBWy229veZ3wXrNSIpZ3/iQEssBoSJJsyH
         FwtZEIo5QRJhnr2RfKltg0gEJlPU/QXafCTlI2x9nY07aDGmspWFUWFVOEQc0SicBCfk
         mSL5qYl05e7yg+gnwbdRDvhuayOsRNe+V7b4Q=
Received: by 10.231.211.134 with SMTP id go6mr223766ibb.143.1275618222562;
        Thu, 03 Jun 2010 19:23:42 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm3007601ibl.10.2010.06.03.19.23.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 19:23:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275551282-21557-1-git-send-email-simo.melenius@iki.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148376>

Simo Melenius wrote:

> If some refs could not be read when listing branches, this can now be
> observed in the exit status of the "git branch" command.

A noble cause.  Thanks.

> +struct append_ref_cb
> +{
> +	struct ref_list *ref_list;
> +	int ret;
> +};

nitpick: the brace should go on the same line to match the other
structs in builtin/branch.c and elsewhere in git.

> @@ -496,7 +507,9 @@ static void print_ref_list(int kinds, int detache=
d, int verbose, int abbrev, str
>  	ref_list.with_commit =3D with_commit;
>  	if (merge_filter !=3D NO_FILTER)
>  		init_revisions(&ref_list.revs, NULL);
> -	for_each_rawref(append_ref, &ref_list);
> +	cb.ref_list =3D &ref_list;
> +	cb.ret =3D 0;
> +	for_each_rawref(append_ref, &cb);
>  	if (merge_filter !=3D NO_FILTER) {
>  		struct commit *filter;
>  		filter =3D lookup_commit_reference_gently(merge_filter_ref, 0);

This can be simplified by "ret =3D for_each_rawref(append_ref, ..."
but the above would have to be added back anyway for patch 2/2.  So
I=E2=80=99m happy with this patch as is.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/builtin/branch.c b/builtin/branch.c
index 46ca59c..77ae444 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -257,8 +257,7 @@ static char *resolve_symref(const char *src, const =
char *prefix)
 	return xstrdup(dst);
 }
=20
-struct append_ref_cb
-{
+struct append_ref_cb {
 	struct ref_list *ref_list;
 	int ret;
 };
--=20
