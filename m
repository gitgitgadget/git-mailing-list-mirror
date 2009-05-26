From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v3] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Mon, 25 May 2009 23:01:28 -0700
Message-ID: <4A1B85B8.1050907@gmail.com>
References: <1243316165-99065-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 08:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8pjH-0007UJ-6F
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 08:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZEZGBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 02:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbZEZGBb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 02:01:31 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:33630 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZEZGBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 02:01:30 -0400
Received: by pxi1 with SMTP id 1so2866829pxi.33
        for <git@vger.kernel.org>; Mon, 25 May 2009 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Ujv8yJGjnAurRoP0eqp5za5PcjZg3UQ8JWt3QUNERVs=;
        b=dAKdTA6AZN8AsbOfDNr6YoJHy/JQ/y30bBANVYF9Hwm9n0jZ/QttlvJTugLL+Mtj0M
         R7AxDEdDEyJxvFHn8MU7MGPHTqZnhsTiCtIBCEKvfAv0HjqQ3AtG9lGQDXYuxq+GG4X5
         vI6odfqJ8kY0OPg++uyHkOHsx2Njp7kYbQmmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NIRfiWqQLrIoTPrS/36M8C7Aq/SBcQC9dSU8JXtA0Rh8IK6/hRs6LC4b71VUil4kH9
         kztXsYHRIpgcIh2fJuXYCug3ugqohJYi6d85TohxgB84hpxphxLXZstQ3IiiDkCVB0fP
         KTyGFIK+xdslO6F6/b3EIBXo9ffDdGWi4hEOg=
Received: by 10.114.146.4 with SMTP id t4mr16441862wad.143.1243317691871;
        Mon, 25 May 2009 23:01:31 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id k37sm15855292waf.7.2009.05.25.23.01.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 23:01:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1243316165-99065-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119996>

David Aguilar wrote:
> -	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
> +	if (pretty_filename) {
> +		struct strbuf pretty_name = STRBUF_INIT;
> +		char *pathdup = xstrdup(path);
> +		char *base = basename(pathdup);
> +		char *dot = strchr(base, '.');
> +		int suffix_len = 0;
> +
> +		if (dot) {
> +			/* path has an extension, e.g. "foo.txt";
> +			 * generate "foo.XXXX.txt".
> +			 */
> +			*dot = '\0';
> +			strbuf_addstr(&pretty_name, base);
> +			*dot = '.';
> +			strbuf_addstr(&pretty_name, ".XXXXXX");
> +			suffix_len = strlen(dot);
> +			strbuf_addstr(&pretty_name, dot);

This *dot business annoys me. Would it be better to use strbuf_add()
with some pointer math thrown in? Also, what happens with files such as
"foo.bar.txt"? Do we want "foo.XXXXX.bar.txt"?
