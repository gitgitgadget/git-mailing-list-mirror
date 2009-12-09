From: Jonathan Nieder <jrnieder@gmail.com>
Subject: error: git-svn died of signal 13
Date: Tue, 8 Dec 2009 23:36:03 -0600
Message-ID: <20091209053602.GA2739@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 06:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIF0i-00084R-SD
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 06:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbZLIFWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 00:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZLIFWh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 00:22:37 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49565 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZLIFWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 00:22:36 -0500
Received: by yxe17 with SMTP id 17so5629054yxe.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 21:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Cu2j1AYmazcB8s2Vdmw6IhU3qyeaXVvhnjvZ5siRQVg=;
        b=tku9YgFn0/MjkYddARYsYokAGX9ZxENcKWvwFrzVTexutADH0RA9PoHOm6boOW0ld3
         //9Ir5fc13GrOZBmalo7m96TTO4nwVs27rcjCNqTngPPhJt6/IIr/uvaOZ3xpuy9FHLJ
         FGYWyCyhu+mVsJPg65bP7/au7EimzVILgIKOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=Eo++OkkCpOnt/Weap6kf7sMr3nD96GJDqlxSp5oJrQePw2jcJNmjxoN1AqIhCK9AF5
         KBgib6at2wFGq12W5IhCiuAra9HDVRzP5NRa1/XB0/dEI6OxRl9OPF/AvRxXi8ettX7n
         APxgPLQOxqOQGPE3Gv47yhngDF1GyFeKsXiYM=
Received: by 10.91.106.5 with SMTP id i5mr8465082agm.75.1260336162115;
        Tue, 08 Dec 2009 21:22:42 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4567272iwn.7.2009.12.08.21.22.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 21:22:41 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134936>

Hi,

Just wanted to pass on a few reports about git-svn dying with SIGPIPE
when trying to fetch large repositories.  It seems to fetch a few
revisions, then die; the repositories can eventually be fetched
successfully by restarting 'git svn fetch' again and again.

Some bug reporters have been very patient, but I don=E2=80=99t really k=
now
where to look or ask in solving this.  Attempts at tracing so far have
given either too little or too much information to make any sense.

The problem goes back at least to v1.5.6.5.

At the end of the git-svn process=E2=80=99s life, the last few function=
 calls
are these:

 - SVN::Ra::Reporter::finish_report and related functions
 - _p_apr_pool_t::DESTROY (libsvn-perl cleaning up, presumably)
 - SVN::Ra::Callbacks::open_tmp_file, called from
   SVN::_Ra::svn_ra_do_update, called from
   Git::SVN::Ra::do_update, called from
   Git::SVN::Ra::gs_do_update
 - Git::SVN::_set_repos_root
 - starting a 'git update-index -z --index-info' to feed commands to

Maybe /tmp is filling up?  It is hard to know, since the SIGPIPE stops
everything and we do not get any nice, simple error message describing
what read or write would have received EPIPE.

See <http://bugs.debian.org/526989>, <http://bugs.debian.org/540150>,
<http://thread.gmane.org/gmane.comp.version-control.git/85868/>.

Any insights?

Jonathan
