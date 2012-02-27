From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Mon, 27 Feb 2012 20:01:41 +0700
Message-ID: <20120227130141.GA8980@do>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org>
 <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 14:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S20EO-0006yc-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 14:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab2B0NCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 08:02:36 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53998 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab2B0NCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 08:02:35 -0500
Received: by daed14 with SMTP id d14so1086425dae.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 05:02:35 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.213.73 as permitted sender) client-ip=10.68.213.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.213.73 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.213.73])
        by 10.68.213.73 with SMTP id nq9mr31131291pbc.17.1330347755525 (num_hops = 1);
        Mon, 27 Feb 2012 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PkFAI3j+LDpW38kpdRYJnn+pgLmEfkngz/cCDUN36gM=;
        b=FFsHm+4UIuMROVdgHT7056oCKcp/6Z33fry6qj4TFd4+YvsLECzUuDs1UOmm6V5SZq
         q5UZvBtR8M14OOoMG6UwtUBqlvZ2XI8dB2j+/St7S0MCmIbBmisXAXOBCgX0HHC6kN/U
         lW+ibMwsinI09dYEcNB12JwsUscW1YHMCkCw0=
Received: by 10.68.213.73 with SMTP id nq9mr26689527pbc.17.1330347755054;
        Mon, 27 Feb 2012 05:02:35 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.186])
        by mx.google.com with ESMTPS id s1sm12678275pbs.21.2012.02.27.05.02.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 05:02:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 20:01:41 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191623>

On Sun, Feb 26, 2012 at 06:11:30PM +0700, Nguyen Thai Ngoc Duy wrote:
> "rev-list --objects" does check for blob existence, in finish_object().

Eck.. I think "--quiet --verify-objects" becomes "--quiet --objects"
because of this code:

-- 8< --
	traverse_commit_list(&revs,
			     quiet ? finish_commit : show_commit,
			     quiet ? finish_object : show_object,
			     &info);
-- 8< --

Unless that's intentional, shouldn't we apply this patch? --quiet's
interfering with rev-list's business sounds weird to me.

-- 8< --
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 264e3ae..95fb605 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -172,19 +172,18 @@ static void finish_object(struct object *obj,
 			  const struct name_path *path, const char *name,
 			  void *cb_data)
 {
+	struct rev_list_info *info = cb_data;
 	if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
 		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
+	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
+		parse_object(obj->sha1);
 }
 
 static void show_object(struct object *obj,
 			const struct name_path *path, const char *component,
 			void *cb_data)
 {
-	struct rev_list_info *info = cb_data;
-
 	finish_object(obj, path, component, cb_data);
-	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
-		parse_object(obj->sha1);
 	show_object_with_name(stdout, obj, path, component);
 } 
-- 8< --
-- 
Duy
